//
//  BaseNetworkWrapper.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface BaseNetworkWrapper : NSObject <SparkDriveDelegate, SparkPrintDelegate>

-(void)sparkGetGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock
             failureBlock:(SparkAuthenticationFailureBlock)failBlock;

-(void)sparkGetAccessToken:(AuthCodeRequest*)authCode
              succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
              failureBlock:(SparkAuthenticationFailureBlock)failBlock;
@end