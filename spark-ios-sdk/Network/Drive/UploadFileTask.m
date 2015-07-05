//
//  UploadFileTask.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "UploadFileTask.h"
#import "Utils.h"
#import "Constants.h"
#import "SparkLogicManager.h"

@implementation UploadFileTask

-(void)executeApiCall{
    
    NSMutableString * urlStr = [NSMutableString string];
    [urlStr appendString:[Utils getBaseURL]];
    [urlStr appendString:@"/"];
    [urlStr appendString:API_UPLOAD_FILE];
    
    NSMutableString * httpPostBody =  [NSMutableString stringWithFormat:@"grant_type=client_credentials"];
    
    NSData * encodeData = [httpPostBody dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:encodeData];
    
    [request setValue:@"form-data; name='file'; filename='credits.txt'" forHTTPHeaderField:@"Content-Disposition"];
    [request setValue:@"ext/plain" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[[SparkLogicManager sharedInstance] appKeySecretBase64] forHTTPHeaderField:@"Authorization"];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSDictionary *JSON =
                               [NSJSONSerialization JSONObjectWithData: data
                                                               options: NSJSONReadingMutableContainers
                                                                 error: &error];
                               
                               if (JSON) {
                                   //_failure(error.localizedDescription);
                               }
                           }];
}
@end
