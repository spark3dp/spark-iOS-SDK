//
//  GuestTokenTask.m
//  spark-ios-sdk
//
//  Created by Autodesk on 6/16/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "GuestTokenTask.h"

@implementation GuestTokenTask

-(instancetype)initGuestTokenTask:(SparkAuthenticationSuccessBlock)succsesBlock
                          failure:(SparkAuthenticationFailureBlock)failBlock{
    self = [super init];
    if (self) {
        _successAuth = succsesBlock;
        _failureAuth = failBlock;
    }
    
    return self;
}


-(void)executeApiCall{
    
    NSMutableString * urlStr = [NSMutableString string];
    [urlStr appendString:[Utils getBaseURL]];
    [urlStr appendString:@"/"];
    [urlStr appendString:SPARK_API_GET_GUEST_TOKEN];

    NSMutableString * httpPostBody =  [NSMutableString stringWithFormat:@"grant_type=client_credentials"];
    
    NSData * encodeData = [httpPostBody dataUsingEncoding:NSUTF8StringEncoding];

    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:20.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:encodeData];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[[SparkLogicManager sharedInstance] appKeySecretBase64] forHTTPHeaderField:@"Authorization"];

    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               NSDictionary *JSON =
                               [NSJSONSerialization JSONObjectWithData: data
                                                               options: NSJSONReadingMutableContainers
                                                                 error: &error];
                               
                               if (JSON) {
                                   
                                   [self onAfterParsing:JSON];

                                   AccessTokenResponse * accessTokenResponse = [[AccessTokenResponse alloc] init];
                                   
                                   accessTokenResponse.accessToken = [JSON objectForKey:@"access_token"];
                                   accessTokenResponse.refreshToken = [JSON objectForKey:@"refresh_token"];
                                   accessTokenResponse.expiresIn = [JSON objectForKey:@"expires_in"];
                                   accessTokenResponse.expiresAt = [JSON objectForKey:@"expires_at"];
                                   _successAuth(accessTokenResponse);
                               }else{
                                   _failureAuth(error.localizedDescription);
                               }
                           }];
}

-(void)onAfterParsing:(NSDictionary*)json{
    [[SparkLogicManager sharedInstance] setAccessToken:[json objectForKey:@"access_token"]];
    [[SparkLogicManager sharedInstance] setRefreshToken:[json objectForKey:@"refresh_token"]];
    [[SparkLogicManager sharedInstance] setAuthorizationType:SPARK_AUTHORIZATION_TOKEN_TYPE_GUEST];
    [[SparkLogicManager sharedInstance] setExpiresAt:[[json objectForKey:@"expires_at"] longValue]];
}






@end
