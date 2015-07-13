//
//  UploadFileTask.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "UploadFileTask.h"
#import <UIKit/UIKit.h>

@implementation UploadFileTask

-(instancetype)initWithFileRequest:(FileRequest*)file
                           success:(SparkSuccessBlock)success
                           failure:(SparkFailureBlock)failure{
    self = [super init];
    if (self) {
        _succes = success;
        _failure = failure;
        _fileRequest = file;
    }
    
    return self;
}

-(void)executeApiCall{
    NSString *boundaryConstant = @"----acebdf13572468";

    NSMutableString * urlStr = [NSMutableString string];
    [urlStr appendString:[Utils getBaseURL]];
    [urlStr appendString:@"/"];
    [urlStr appendString:API_UPLOAD_FILE];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"filename\"; filename=\"TeaPot.obj\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: text/plain" dataUsingEncoding:NSUTF8StringEncoding]];

    
    if (_fileRequest.fileData){
        [body appendData:_fileRequest.fileData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Disposition: form-data; name=\"public\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString * public = _fileRequest.publicEnable ? @"true" : @"false";
    [body appendData:[[NSString stringWithFormat:@"%@\r\n\r\n", public] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[@"Content-Disposition: form-data; name=\"unzip\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSString * zip = _fileRequest.zipEnable ? @"true" : @"false";
    [body appendData:[[NSString stringWithFormat:@"%@\r\n\r\n", zip] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];


    [request setHTTPBody:body];

    
    //headers
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@", [[SparkLogicManager sharedInstance] accessToken]] forHTTPHeaderField:@"Authorization"];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (!error) {
                                   NSDictionary *JSON =
                                   [NSJSONSerialization JSONObjectWithData: data
                                                                   options: NSJSONReadingMutableContainers
                                                                     error: &error];
                                   
                                   if (JSON) {
                                       NSArray *files = [JSON objectForKey:@"files"];
                                       if ([files count] == 0) {
                                           _failure(@"missing files");
                                       }
                                       FileResponse * fileResponse = [[FileResponse alloc] init];

                                       if ([files count] == 1) {
                                           fileResponse.name = [[files objectAtIndex:0] objectForKey:@"name"];
                                           fileResponse.fileId = [[files objectAtIndex:0] objectForKey:@"file_id"];
                                           fileResponse.md5sum = [[files objectAtIndex:0] objectForKey:@"md5sum"];
                                           fileResponse.publicUrl = [[files objectAtIndex:0] objectForKey:@"public_url"];
                                       }else{
                                           NSMutableArray * fileArray = [NSMutableArray array];

                                           for (NSDictionary * fileDict in files) {
                                               FileResponse * fileResponse = [[FileResponse alloc] init];
                                               fileResponse.name = [fileDict objectForKey:@"name"];
                                               fileResponse.fileId = [fileDict objectForKey:@"file_id"];
                                               fileResponse.md5sum = [fileDict objectForKey:@"md5sum"];
                                               fileResponse.publicUrl = [fileDict objectForKey:@"public_url"];
                                               [fileArray addObject:fileResponse];
                                           }
                                           
                                           [fileResponse setFiles:fileArray];
                                       }
                                      
                                       _succes(fileResponse);
                                   }
                               }else{
                                   _failure(error.localizedDescription);
                               }
                           }];
}

@end
