//
//  SparkAuthentication.m
//  Spark-sdk-demo
//
//  Created by Autodesk on 6/28/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "SparkAuthentication.h"
#import "SparkManager.h"


@implementation SparkAuthentication

static SparkAuthentication *sharedInstance = nil;

+ (SparkAuthentication *)sharedInstance {
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[SparkAuthentication alloc] init];
    });
    
    return sharedInstance;
}

- (void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock
              failure:(SparkAuthenticationFailureBlock)failBlock;
{
 
    if ([[SparkManager sharedInstance] checkPreAccessToken]) {
        [self.networkUtils getGuestToken:succsesBlock failure:failBlock];
    }
}


- (void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock
                     failure:(SparkAuthenticationFailureBlock)failBlock
        parentViewController:(UIViewController*)parent{
    
    [_networkUtils getAuthorizationCode:succsesBlock failure:failBlock parentViewController:parent];
}



@end
