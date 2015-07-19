//
//  BaseNetworkWrapper.m
//  spark-ios-sdk
//
//  Created by Autodesk on 6/14/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "BaseNetworkWrapper.h"
#import "GuestTokenTask.h"
#import "AccessTokenTask.h"
#import "RefreshTokenTask.h"
#import "UploadFileTask.h"
#import "MeshImportTask.h"

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
}

-(void)sparkGetAssetsSuccess:(SparkSuccessBlock)success
                     failure:(SparkFailureBlock)failure{
}

-(void)sparkGetMemberAssets:(MemberRequest*)member
                    success:(SparkSuccessBlock)success
                    failure:(SparkFailureBlock)failure {
}

-(void)sparkGetMember:(MemberRequest*)member
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure {
}

-(void)sparkCreateAsset:(AssetRequest*)asset
                success:(SparkSuccessBlock)success
                failure:(SparkFailureBlock)failure{
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
}

-(void)sparkUnregisterPrinter:(PrinterUnregisterRequest*)printer
                      success:(SparkSuccessBlock)success
                      failure:(SparkFailureBlock)failure {
}

-(void)sparkCreateJob:(CreateJobRequest*)printerJob
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure{
}

-(void)sparkCommandSend:(CommandSendRequest*)command
                success:(SparkSuccessBlock)success
                failure:(SparkFailureBlock)failure{
}

-(void)sparkJobStatus:(PrinterJobStatusRequest*)job
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure {
}

-(void)sparkMeshImport:(MeshImportRequest*)meshImportRequest
               success:(SparkSuccessBlock)success
               failure:(SparkFailureBlock)failure {
    MeshImportTask * mit = [[MeshImportTask alloc] initWithMeshImportRequest:meshImportRequest success:success failure:failure];
    [mit executeApiCall];
}

@end
