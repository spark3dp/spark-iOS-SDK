//
//  AccessTokenTask.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/30/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSparkRequest.h"
#import "Protocols.h"
#import "AuthCodeRequest.h"

@interface AccessTokenTask : BaseSparkRequest{
    AuthCodeRequest* _authCode;
}

-(instancetype)initAccessTokenTask:(AuthCodeRequest*)authCode
                      succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
                      failureBlock:(SparkAuthenticationFailureBlock)failBlock;

-(void)executeApiCall;
@end
