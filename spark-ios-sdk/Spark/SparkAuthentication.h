//
//  SparkAuthentication.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/28/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "AccessTokenResponse.h"
#import "NetworkUtils.h"


@interface SparkAuthentication : NSObject

@property (nonatomic, strong) NetworkUtils * networkUtils;

+ (SparkAuthentication *)sharedInstance;
- (void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;
- (void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;


@end
