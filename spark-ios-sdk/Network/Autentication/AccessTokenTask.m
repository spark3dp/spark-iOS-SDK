//
//  AccessTokenTask.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/30/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "AccessTokenTask.h"
#import "Utils.h"
#import "Constants.h"
#import "SparkLogicManager.h"

@implementation AccessTokenTask

-(instancetype)initAccessTokenTask:(AuthCodeRequest*)authCode
                      succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
                      failureBlock:(SparkAuthenticationFailureBlock)failBlock{
    
    self = [super init];
    if (self) {
        _succes = succsesBlock;
        _failure = failBlock;
        _authCode = authCode;
    }
    
    return self;
}


-(void)executeApiCall{
    
    NSMutableString * urlStr = [NSMutableString string];
    [urlStr appendString:[Utils getBaseURL]];
    [urlStr appendString:@"/"];
    [urlStr appendString:API_GET_GUEST_TOKEN];
    
    NSMutableString * httpPostBody =  [NSMutableString stringWithFormat:@"grant_type=authorization_code&code=%@&response_type=code&redirect_uri=http://www.autodesk.com", _authCode.autoCode];
    
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
                                   _succes(accessTokenResponse);
                               }else{
                                   _failure(error.localizedDescription);
                               }
                           }];
}

-(void)onAfterParsing:(NSDictionary*)json{
    [[SparkLogicManager sharedInstance] setAccessToken:[json objectForKey:@"access_token"]];
    [[SparkLogicManager sharedInstance] setRefreshToken:[json objectForKey:@"refresh_token"]];
    [[SparkLogicManager sharedInstance] setAuthorizationType:SPARK_AUTHORIZATION_TOKEN_TYPE_REGULAR];
    [[SparkLogicManager sharedInstance] setExpiresAt:[[json objectForKey:@"expires_at"] longValue]];
}


@end
