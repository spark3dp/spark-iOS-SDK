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
#import "AssetRequest.h"
#import "MemberRequest.h"
#import "FileRequest.h"
#import "PrinterRegisterRequest.h"
#import "PrinterUnregisterRequest.h"
#import "CreateJobRequest.h"
#import "CommandSendRequest.h"
#import "PrinterJobStatusRequest.h"


@protocol SparkResponseDelegate <NSObject>
@optional

-(void)onSparkSuccess:(id)responseObject;

-(void)onSparkFailure:(NSString*)errorMessage;

@end


@protocol SparkAuthenticationDelegate <NSObject>
@optional

-(void)sparkGetGuestToken:(id<SparkResponseDelegate>) onGuestTokenResponse;

-(void)sparkGetAccessToken:(AuthCodeRequest*)authCode accessTokenResponse:(id<SparkResponseDelegate>)onAccessTokenResponse;

-(void)sparkGetRefreshToken:(RefreshAccessTokenRequest*)refreshCode accessTokenResponse:(id<SparkResponseDelegate>) onRefreshTokenResponse;

@end


@protocol SparkDriveDelegate <NSObject>
@optional

-(void)sparkGetAsset:(AssetRequest*)asset assetResponse:(id<SparkResponseDelegate>) onAssetResponse;

-(void)sparkGetAssets:(id<SparkResponseDelegate>) onAssetResponse;

-(void)sparkGetMemberAssets:(MemberRequest*) member assetsListResponse:(id<SparkResponseDelegate>) onAssetsResponse;

-(void)sparkGetMember:(MemberRequest*) member memberResponse:(id<SparkResponseDelegate>) onMemberResponse;

-(void)sparkCreateAsset:(AssetRequest*) asset assetResponse:(id<SparkResponseDelegate>) onCreateAssetResponse;

-(void)sparkCreateFile:(FileRequest*) file filesResponse:(id<SparkResponseDelegate>) onSparkResponse;

@end

@protocol SparkPrintDelegate <NSObject>
@optional

-(void)sparkRegisterPrinter:(PrinterRegisterRequest*)printer printerRegisterResponse:(id<SparkResponseDelegate>) onSparkResponse;

-(void)sparkUnregisterPrinter:(PrinterUnregisterRequest*)printer object:(id<SparkResponseDelegate>) onSparkResponse;

-(void)sparkCreateJob:(CreateJobRequest*)printerJob createJobResponse:(id<SparkResponseDelegate>) onSparkResponse;

-(void)sparkCommandSend:(CommandSendRequest*)command commandSendResponse:(id<SparkResponseDelegate>) onSparkResponse;

-(void)sparkJobStatus:(PrinterJobStatusRequest*)job printerJobStatusResponse:(id<SparkResponseDelegate>) onSparkResponse;

@end
#endif
