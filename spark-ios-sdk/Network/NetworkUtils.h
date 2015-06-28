//
//  NetworkUtils.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkWrapper.h"

@interface NetworkUtils : NSObject

@property (nonatomic, strong) BaseNetworkWrapper * baseNetworkWrapper;

-(void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;
-(void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;

@end
