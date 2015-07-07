//
//  BaseSparkRequest.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/16/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface BaseSparkRequest : NSObject{
    SparkAuthenticationSuccessBlock _succesAuth;
    SparkAuthenticationFailureBlock _failureAuth;
    SparkSuccessBlock _succes;
    SparkFailureBlock _failure;
}

@end
