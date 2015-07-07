//
//  BaseNetworkWrapper.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"

@interface BaseNetworkWrapper : NSObject 

-(void)sparkGetGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock
             failureBlock:(SparkAuthenticationFailureBlock)failBlock;

-(void)sparkGetAccessToken:(AuthCodeRequest*)authCode
              succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
              failureBlock:(SparkAuthenticationFailureBlock)failBlock;


-(void)sparkGetRefreshToken:(RefreshAccessTokenRequest*)refreshCode
                    success:(SparkAuthenticationSuccessBlock)success
                    failure:(SparkAuthenticationFailureBlock)failure;

-(void)sparkGetAsset:(AssetRequest*)asset
             success:(SparkSuccessBlock)success
             failure:(SparkFailureBlock)failure;

-(void)sparkGetAssetsSuccess:(SparkSuccessBlock)success
                     failure:(SparkFailureBlock)failure;

-(void)sparkGetMemberAssets:(MemberRequest*)member
                    success:(SparkSuccessBlock)success
                    failure:(SparkFailureBlock)failure;

-(void)sparkGetMember:(MemberRequest*)member
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure;

-(void)sparkCreateAsset:(AssetRequest*)asset
                success:(SparkSuccessBlock)success
                failure:(SparkFailureBlock)failure;

-(void)sparkUploadFile:(FileRequest*)file
               success:(SparkSuccessBlock)success
               failure:(SparkFailureBlock)failure;

-(void)sparkRegisterPrinter:(PrinterRegisterRequest*)printer
                    success:(SparkSuccessBlock)success
                    failure:(SparkFailureBlock)failure;

-(void)sparkUnregisterPrinter:(PrinterUnregisterRequest*)printer
                      success:(SparkSuccessBlock)success
                      failure:(SparkFailureBlock)failure;

-(void)sparkCreateJob:(CreateJobRequest*)printerJob
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure;

-(void)sparkCommandSend:(CommandSendRequest*)command
                success:(SparkSuccessBlock)success
                failure:(SparkFailureBlock)failure;

-(void)sparkJobStatus:(PrinterJobStatusRequest*)job
              success:(SparkSuccessBlock)success
              failure:(SparkFailureBlock)failure;

@end