//
//  GuestTokenTask.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/16/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSparkRequest.h"
#import "Protocols.h"

@interface GuestTokenTask : BaseSparkRequest

-(instancetype)initGuestTokenTask:(SparkAuthenticationSuccessBlock)succsesBlock
                          failure:(SparkAuthenticationFailureBlock)failBlock;
-(void)executeApiCall;
@end
