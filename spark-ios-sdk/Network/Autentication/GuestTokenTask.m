//
//  GuestTokenTask.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/16/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "GuestTokenTask.h"
#import "Utils.h"
#import "Constants.h"
#import "SparkLogicManager.h"

@implementation GuestTokenTask

-(instancetype)initGuestTokenTask:(SparkAuthenticationSuccessBlock)succsesBlock
                          failure:(SparkAuthenticationFailureBlock)failBlock{
    self = [super init];
    if (self) {
        _succes = succsesBlock;
        _failure = failBlock;
    }
    
    return self;
}


-(void)executeApiCall{
    
    NSMutableString * urlStr = [NSMutableString string];
    [urlStr appendString:[Utils getBaseURL]];
    [urlStr appendString:@"/"];
    [urlStr appendString:API_GET_GUEST_TOKEN];

    NSMutableString * httpPostBody =  [NSMutableString stringWithFormat:@"grant_type=client_credentials&client_id=%@&client_secret=%@",
                                       [[SparkLogicManager sharedInstance] appKey],
                                       [[SparkLogicManager sharedInstance] appSecret]];
    
    NSData * encodeData = [httpPostBody dataUsingEncoding:NSUTF8StringEncoding];

    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:encodeData];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               //NSString* encodeRespose = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               
                               NSDictionary *JSON =
                               [NSJSONSerialization JSONObjectWithData: data
                                                               options: NSJSONReadingMutableContainers
                                                                 error: &error];
                               
                               if (JSON) {
                                   AccessTokenResponse * accessTokenResponse = [[AccessTokenResponse alloc] init];
                                   
                                   accessTokenResponse.accessToken = [JSON objectForKey:@"access_token"];
                                   accessTokenResponse.refreshToken = [JSON objectForKey:@"refresh_token"];
                                   accessTokenResponse.expiresIn = [JSON objectForKey:@"expires_in"];
                                   accessTokenResponse.expiresAt = [JSON objectForKey:@"expires_at"];
                                   _succes(accessTokenResponse);
                               }else{
                                   _failure(error.localizedDescription);
                               }
                              
                           }];
}









@end
