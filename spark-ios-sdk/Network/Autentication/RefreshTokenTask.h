//
//  RefreshTokenTask.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/6/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSparkRequest.h"
#import "Protocols.h"

@interface RefreshTokenTask : BaseSparkRequest{
    RefreshAccessTokenRequest * _refreshAccessTokenRequest;
}

-(instancetype)initRefreshTokenTask:(RefreshAccessTokenRequest*)refreshCode
                       succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
                       failureBlock:(SparkAuthenticationFailureBlock)failBlock;
-(void)executeApiCall;

@end
