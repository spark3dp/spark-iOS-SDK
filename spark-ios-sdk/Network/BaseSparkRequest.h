//
//  BaseSparkRequest.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/16/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "Utils.h"
#import "Constants.h"
#import "SparkLogicManager.h"

@interface BaseSparkRequest : NSObject{
    SparkAuthenticationSuccessBlock _successAuth;
    SparkAuthenticationFailureBlock _failureAuth;
    SparkSuccessBlock _succes;
    SparkFailureBlock _failure;
}

@end
