//
//  BaseNetworkWrapper.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "BaseNetworkWrapper.h"
#import "GuestTokenTask.h"
#import "AccessTokenTask.h"
#import "RefreshTokenTask.h"
#import "UploadFileTask.h"

@implementation BaseNetworkWrapper
//-------------------------------------------------
//SparkAuthenticationDelegate
//-------------------------------------------------
-(void)sparkGetGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock
             failureBlock:(SparkAuthenticationFailureBlock)failBlock{
    
    GuestTokenTask * gtt = [[GuestTokenTask alloc] initGuestTokenTask:succsesBlock failure:failBlock];
    [gtt executeApiCall];
}

-(void)sparkGetAccessToken:(AuthCodeRequest*)authCode
              succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
             failureBlock:(SparkAuthenticationFailureBlock)failBlock{
    AccessTokenTask *att = [[AccessTokenTask alloc] initAccessTokenTask:authCode succsesBlock:succsesBlock failureBlock:failBlock];
    [att executeApiCall];
}

-(void)sparkGetRefreshToken:(RefreshAccessTokenRequest*)refreshRequest
                    success:(SparkAuthenticationSuccessBlock)success
                    failure:(SparkAuthenticationFailureBlock)failure{
    
    RefreshTokenTask * rtt = [[RefreshTokenTask alloc] initRefreshTokenTask:refreshRequest succsesBlock:success failureBlock:failure];
    [rtt executeApiCall];
}

//-------------------------------------------------
//SparkDriveDelegate
//-------------------------------------------------
-(void)sparkGetAsset:(AssetRequest*)asset
             success:(SparkSuccessBlock)success
             failure:(SparkFailureBlock)failure{
    //new AssetTask(asset, onAssetResponse).execute(getQueue());
}

-(void)sparkGetAssetsSuccess:(SparkSuccessBlock)success
                     failure:(SparkFailureBlock)failure{
    //new AssetsListRequest(onAssetResponse).execute(getQueue());
}

-(void)sparkGetMemberAssets:(MemberRequest*)member
                    success:(SparkSuccessBlock)success
                    failure:(SparkFailureBlock)failure {
    //new MemberAssetsListRequest(member,onAssetsResponse).execute(getQueue());
}

-(void)sparkGetMember:(MemberRequest*)member
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure {
    //new MemberTask(member,onMemberResponse).execute(getQueue());
}

-(void)sparkCreateAsset:(AssetRequest*)asset
                success:(SparkSuccessBlock)success
                failure:(SparkFailureBlock)failure{
    //new CreateAssetTask(asset, onCreateAssetResponse).execute(getQueue());
}

-(void)sparkUploadFile:(FileRequest*)fileRequest
               success:(SparkSuccessBlock)success
               failure:(SparkFailureBlock)failure {
    UploadFileTask * uft = [[UploadFileTask alloc] initWithFileRequest:fileRequest success:success failure:failure];
    [uft executeApiCall];
}

//-------------------------------------------------
//SparkPrintDelegate
//-------------------------------------------------
-(void)sparkRegisterPrinter:(PrinterRegisterRequest*)printer
                    success:(SparkSuccessBlock)success
                    failure:(SparkFailureBlock)failure{
    //new RegisterPrinterTask(printer, onSparkResponse).execute(getQueue());
}

-(void)sparkUnregisterPrinter:(PrinterUnregisterRequest*)printer
                      success:(SparkSuccessBlock)success
                      failure:(SparkFailureBlock)failure {
    //new UnregisterPrinterTask(printer,onSparkResponse).execute(getQueue());
}

-(void)sparkCreateJob:(CreateJobRequest*)printerJob
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure{
    //new CreateJobTask(printerJob, onSparkResponse).execute(getQueue());
}

-(void)sparkCommandSend:(CommandSendRequest*)command
                success:(SparkSuccessBlock)success
                failure:(SparkFailureBlock)failure{
    //new CommandSendTask(command, onSparkResponse).execute(getQueue());
}

-(void)sparkJobStatus:(PrinterJobStatusRequest*)job
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure {
    //new PrinterJobStatusTask(job,onSparkResponse).execute(getQueue());
}

@end
