//
//  AccessTokenTask.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 6/30/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
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
