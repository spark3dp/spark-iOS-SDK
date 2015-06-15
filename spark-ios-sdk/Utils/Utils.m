//
//  Utils.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"
#import "SparkLogicManager.h"

@implementation Utils

+(BOOL)checkForPermissions{
    return YES;
}

+(NSString*)getBaseURL{
    
    return ([[SparkLogicManager sharedInstance] baseURLType] == SPARK_ENV_TYPE_SANBOX) ? SPARK_BASE_URL_SANDBOX : SPARK_BASE_URL_PRODUCTION;
}

+(BOOL)needToUpdateAccessToken{
    
    if (SPARK_AUTHORIZATION_TOKEN_TYPE_REGULAR == [[SparkLogicManager sharedInstance] authorizationType])
    {
        // only on auth 2.0 there are refresh token
        if ([[SparkLogicManager sharedInstance] refreshToken] != nil)
        {
            // check if the time is correct to refresh the token
            
            long expireTime = [[SparkLogicManager sharedInstance] expiresAt];
            
            return ([[NSDate date] timeIntervalSince1970] * 1000 > expireTime);
        }
    }
    
    return NO;
}
@end
