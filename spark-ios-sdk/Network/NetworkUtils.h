//
//  NetworkUtils.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/14/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseNetworkWrapper.h"

typedef enum ActionType
{
    AT_SPARK_GET_ASSET,
    AT_SPARK_GET_ASSETS,
    AT_SPARK_GET_MEMBER_ASSETS,
    AT_SPARK_GET_MEMBER,
    AT_SPARK_CREATE_ASSET,
    AT_SPARK_UPLOAD_FILE,
    AT_SPARK_MESH_IMPORT,
    AT_SPARK_REGISTER_PRINTER,
    AT_SPARK_UNREGISTER_PRINTER,
    AT_SPARK_CREATE_JOB,
    AT_SPARK_COMMAND_SEND,
    AT_SPARK_JOB_STATUS
    
} ActionType;

@interface NetworkUtils : NSObject <UIWebViewDelegate>{
    UIWebView * _webview;
    UIView * _bgView;
    SparkAuthenticationSuccessBlock _succsesBlock;
    SparkAuthenticationFailureBlock _failBlock;
    SparkSuccessBlock _succses;
    SparkFailureBlock _failure;
    ActionType _action;
    id _object;
}

@property (nonatomic, strong) BaseNetworkWrapper * baseNetworkWrapper;

-(void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;
-(void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock
                    failure:(SparkAuthenticationFailureBlock)failBlock
       parentViewController:(UIViewController*)parent;

-(void)getAsset:(AssetRequest*)asset
        success:(SparkSuccessBlock)success
        failure:(SparkFailureBlock)failure;

-(void)getAssetsListSuccess:(SparkSuccessBlock)success
                    failure:(SparkFailureBlock)failure;

-(void)uploadFile:(FileRequest*)file
          success:(SparkSuccessBlock)success
          failure:(SparkFailureBlock)failure;

-(void)meshImport:(MeshImportRequest*)meshImportRequest
          success:(SparkSuccessBlock)success
          failure:(SparkFailureBlock)failure;
@end
