//
//  Protocols.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#ifndef spark_ios_sdk_Protocols_h
#define spark_ios_sdk_Protocols_h

#import "AuthCodeRequest.h"
#import "RefreshAccessTokenRequest.h"
#import "MeshImportRequest.h"
#import "AssetRequest.h"
#import "MemberRequest.h"
#import "FileRequest.h"
#import "PrinterRegisterRequest.h"
#import "PrinterUnregisterRequest.h"
#import "CreateJobRequest.h"
#import "CommandSendRequest.h"
#import "PrinterJobStatusRequest.h"
#import "AccessTokenResponse.h"
#import "FileResponse.h"

typedef void(^SparkAuthenticationSuccessBlock)(AccessTokenResponse* responseObject);
typedef void(^SparkAuthenticationFailureBlock)(NSString* error);
typedef void(^SparkSuccessBlock)(id responseObject);
typedef void(^SparkFailureBlock)(NSString* error);

#endif
