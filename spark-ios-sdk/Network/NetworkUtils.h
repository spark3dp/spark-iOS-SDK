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

/** receive guest token from server.
 *
 * @param succsesBlock, on success return SparkAuthenticationSuccessBlock class.
 * @param failBlock return SparkAuthenticationFailureBlock class.
 */
-(void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;

/** receive Authorize token from server.
 *
 * @param succsesBlock, on success return SparkAuthenticationSuccessBlock class.
 * @param failBlock return SparkAuthenticationFailureBlock class.
 */
-(void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock
                    failure:(SparkAuthenticationFailureBlock)failBlock
       parentViewController:(UIViewController*)parent;

/** sendfile to server.
 *
 * @param fileRequest, file request obj that describe the uploaded file.
 * @param success, on success return SparkSuccessBlock class.
 * @param failure return SparkFailureBlock class.
 */
-(void)uploadFile:(FileRequest*)fileRequest
          success:(SparkSuccessBlock)success
          failure:(SparkFailureBlock)failure;

/** Mesh Import from server.
 *
 * @param meshImportRequest, mesh request obj that describe the uploaded mesh.
 * @param success, on success return SparkSuccessBlock class.
 * @param failure return SparkFailureBlock class.
 */
-(void)meshImport:(MeshImportRequest*)meshImportRequest
          success:(SparkSuccessBlock)success
          failure:(SparkFailureBlock)failure;
@end
