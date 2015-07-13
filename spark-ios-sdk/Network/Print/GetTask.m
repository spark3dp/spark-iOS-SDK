//
//  GetTask.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/9/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "GetTask.h"
#import "Utils.h"
#import "Constants.h"
#import "SparkLogicManager.h"

@implementation GetTask

-(instancetype)initWithTaskId:(NSString*)taskId
                      success:(SparkSuccessBlock)success
                      failure:(SparkFailureBlock)failure{
    self = [super init];
    if (self) {
        _succes = success;
        _failure = failure;
        _taskId = taskId;
    }
    
    return self;
}

-(void)executeApiCall{
    NSMutableString * urlStr = [NSMutableString string];
    [urlStr appendString:[Utils getBaseURL]];
    [urlStr appendString:@"/"];
    [urlStr appendString:API_GET_TASK];
    [urlStr appendString:@"/"];
    [urlStr appendString:_taskId];

    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"GET"];
    
    //headers
    [request setValue:[NSString stringWithFormat:@"Bearer %@", [[SparkLogicManager sharedInstance] accessToken]] forHTTPHeaderField:@"Authorization"];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSDictionary *JSON =
                               [NSJSONSerialization JSONObjectWithData: data
                                                               options: NSJSONReadingMutableContainers
                                                                 error: &error];
                               if (JSON) {
                                   NSString * status = [JSON objectForKey:@"status"];
                                   if ([status isEqualToString:@"running"]) {
                                       NSLog(@"task running");
                                       [self performSelector:@selector(executeApiCall) withObject:nil afterDelay:1.0];
                                   }else{
                                       _succes(nil);
                                   }
                                }else{
                                   _failure(error.localizedDescription);
                               }
                           }];


}

@end
