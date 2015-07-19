//
//  SparkAuthentication.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 6/28/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "AccessTokenResponse.h"
#import "NetworkUtils.h"


@interface SparkAuthentication : NSObject

@property (nonatomic, strong) NetworkUtils * networkUtils;

+ (SparkAuthentication *)sharedInstance;
- (void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;
- (void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock
                     failure:(SparkAuthenticationFailureBlock)failBlock
        parentViewController:(UIViewController*)parent;


@end
