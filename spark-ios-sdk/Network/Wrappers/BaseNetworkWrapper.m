//
//  BaseNetworkWrapper.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "BaseNetworkWrapper.h"
#import "GuestTokenTask.h"

@implementation BaseNetworkWrapper
//-------------------------------------------------
//SparkAuthenticationDelegate
//-------------------------------------------------
-(void)sparkGetGuestToken:(id<SparkResponseDelegate>) onGuestTokenResponse{
    GuestTokenTask * gtt = [[GuestTokenTask alloc] initGuestTokenTask:onGuestTokenResponse];
    [gtt executeApiCall];
}

-(void)sparkGetAccessToken:(AuthCodeRequest*)authCode accessTokenResponse:(id<SparkResponseDelegate>)onAccessTokenResponse{
    //new AccessTokenTask(authCode,onAccessTokenResponse).execute(getQueue());
}

-(void)sparkGetRefreshToken:(RefreshAccessTokenRequest*)refreshCode accessTokenResponse:(id<SparkResponseDelegate>) onRefreshTokenResponse{
    //new RefreshTokenTask(refreshCode,onRefreshTokenResponse).execute(getQueue());
}

//-------------------------------------------------
//SparkDriveDelegate
//-------------------------------------------------
-(void)sparkGetAsset:(AssetRequest*)asset assetResponse:(id<SparkResponseDelegate>) onAssetResponse{
    //new AssetTask(asset, onAssetResponse).execute(getQueue());
}

-(void)sparkGetAssets:(id<SparkResponseDelegate>)onAssetResponse{
    //new AssetsListRequest(onAssetResponse).execute(getQueue());
}

-(void)sparkGetMemberAssets:(MemberRequest*) member assetsListResponse:(id<SparkResponseDelegate>) onAssetsResponse {
    //new MemberAssetsListRequest(member,onAssetsResponse).execute(getQueue());
}

-(void)sparkGetMember:(MemberRequest*) member memberResponse:(id<SparkResponseDelegate>) onMemberResponse {
    //new MemberTask(member,onMemberResponse).execute(getQueue());
}

-(void)sparkCreateAsset:(AssetRequest*) asset assetResponse:(id<SparkResponseDelegate>) onCreateAssetResponse{
    //new CreateAssetTask(asset, onCreateAssetResponse).execute(getQueue());
}

-(void)sparkCreateFile:(FileRequest*) file filesResponse:(id<SparkResponseDelegate>) onSparkResponse {
    //new CreateFileTask(file, onSparkResponse).execute(getQueue());
}

//-------------------------------------------------
//SparkPrintDelegate
//-------------------------------------------------
-(void)sparkRegisterPrinter:(PrinterRegisterRequest*)printer printerRegisterResponse:(id<SparkResponseDelegate>) onSparkResponse{
    //new RegisterPrinterTask(printer, onSparkResponse).execute(getQueue());
}

-(void)sparkUnregisterPrinter:(PrinterUnregisterRequest*)printer object:(id<SparkResponseDelegate>) onSparkResponse {
    //new UnregisterPrinterTask(printer,onSparkResponse).execute(getQueue());
}

-(void)sparkCreateJob:(CreateJobRequest*)printerJob createJobResponse:(id<SparkResponseDelegate>) onSparkResponse{
    //new CreateJobTask(printerJob, onSparkResponse).execute(getQueue());
}

-(void)sparkCommandSend:(CommandSendRequest*)command commandSendResponse:(id<SparkResponseDelegate>) onSparkResponse{
    //new CommandSendTask(command, onSparkResponse).execute(getQueue());
}

-(void)sparkJobStatus:(PrinterJobStatusRequest*)job printerJobStatusResponse:(id<SparkResponseDelegate>) onSparkResponse {
    //new PrinterJobStatusTask(job,onSparkResponse).execute(getQueue());
}

@end
