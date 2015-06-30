//
//  NetworkUtils.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "NetworkUtils.h"
#import "AssetRequest.h"
#import "MemberRequest.h"
#import "AuthCodeRequest.h"
#import "RefreshAccessTokenRequest.h"
#import "FileRequest.h"
#import "PrinterRegisterRequest.h"
#import "PrinterJobStatusRequest.h"
#import "CommandSendRequest.h"
#import "Utils.h"
#import "Constants.h"
#import "RefreshAccessTokenRequest.h"
#import "SparkLogicManager.h"

@implementation NetworkUtils

typedef enum ActionType
{
    AT_SPARK_GET_ASSET,
    AT_SPARK_GET_ASSETS,
    AT_SPARK_GET_MEMBER_ASSETS,
    AT_SPARK_GET_MEMBER,
    AT_SPARK_CREATE_ASSET,
    AT_SPARK_CREATE_FILE,
    AT_SPARK_REGISTER_PRINTER,
    AT_SPARK_UNREGISTER_PRINTER,
    AT_SPARK_CREATE_JOB,
    AT_SPARK_COMMAND_SEND,
    AT_SPARK_JOB_STATUS
    
} ActionType;

-(instancetype)init{
    self = [super init];
    if (self) {
        _baseNetworkWrapper = [[BaseNetworkWrapper alloc] init];
    }
    
    return self;
}

// API with no need of Access Token
//----------------------------------

-(void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock {
    // Call the class that encapsulate the call
    [_baseNetworkWrapper sparkGetGuestToken:succsesBlock failureBlock:failBlock];
}

-(void)getAccessToken:(AuthCodeRequest*)authCode
         succsesBlock:(SparkAuthenticationSuccessBlock)succsesBlock
         failureBlock:(SparkAuthenticationFailureBlock)failBlock{
    
    // Call the class that encapsulate the call
    [_baseNetworkWrapper sparkGetAccessToken:authCode succsesBlock:succsesBlock failureBlock:failBlock];
}

-(void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock  parentViewController:(UIViewController*)parent {
    
    _succsesBlock = succsesBlock;
    _failBlock = failBlock;
    
    [self initAndShowWebviewWithParent:parent];
}

-(void)getRefreshToken:(RefreshAccessTokenRequest*)refreshCode accessTokenResponse:(id<SparkResponseDelegate>) onRefreshTokenResponse {
    
    //[_baseNetworkWrapper sparkGetRefreshToken:refreshCode accessTokenResponse:onRefreshTokenResponse];
}

-(void)callWithUpdateRefreshToken:(ActionType)action withObject:(id)object responde:(id<SparkResponseDelegate>) onResponse {
    // override the flag
    [self callWithUpdateRefreshToken:action withObject:object responde:onResponse checkToken:NO];
}
     
-(void)callWithUpdateRefreshToken:(ActionType)action withObject:(id)object responde:(id<SparkResponseDelegate>)onResponse checkToken:(BOOL)checkToken {
    
    if (checkToken && [self isGuestTokenType:onResponse]) {
        //on guest token type raise error and quit
        return;
    }
    
    if ([Utils needToUpdateAccessToken]){
       
        RefreshAccessTokenRequest * ratr = [[RefreshAccessTokenRequest alloc] initWithRefreshCode:[[SparkLogicManager sharedInstance] refreshToken]];
        
        [self getRefreshToken:ratr accessTokenResponse:onResponse];
        
//        // update call
//        getRefreshToken(new RefreshAccessTokenRequest(MemoryManager.getInstance().getRefreshToken()), new ISparkResponse<AccessTokenResponse>() {
//            @Override
//            public void onSparkSuccess(AccessTokenResponse responseObject) {
//                
//                action.run();
//            }
//            
//            @Override
//            public void onSparkFailure(String errorMessage) {
//                
//                onResponse.onSparkFailure(errorMessage);
//                
//                // on refresh error, try to open the login screen again
//                initAndShowWebview(new ISparkResponse<AccessTokenResponse>() {
//                    @Override
//                    public void onSparkSuccess(AccessTokenResponse responseObject) {
//                        
//                        // on success, call the action to perform
//                        action.run();
//                    }
//                    
//                    @Override
//                    public void onSparkFailure(String errorMessage) {
//                        
//                    }
//                });
//                
//                
//            }
//        });
        
    } else {
        // regular call
        switch (action) {
            case AT_SPARK_GET_ASSET:
                [_baseNetworkWrapper sparkGetAsset:object assetResponse:onResponse];
                break;
            case AT_SPARK_GET_ASSETS:
                [_baseNetworkWrapper sparkGetAssets:onResponse];
                break;
            case AT_SPARK_GET_MEMBER_ASSETS:
                [_baseNetworkWrapper sparkGetMemberAssets:object assetsListResponse:onResponse];
                break;
            case AT_SPARK_GET_MEMBER:
                [_baseNetworkWrapper sparkGetMember:object memberResponse:onResponse];
                break;
            case AT_SPARK_CREATE_ASSET:
                [_baseNetworkWrapper sparkCreateAsset:object assetResponse:onResponse];
                break;
            case AT_SPARK_CREATE_FILE:
                [_baseNetworkWrapper sparkCreateFile:object filesResponse:onResponse];
                break;
            case AT_SPARK_REGISTER_PRINTER:
                [_baseNetworkWrapper sparkRegisterPrinter:object printerRegisterResponse:onResponse];
                break;
            case AT_SPARK_UNREGISTER_PRINTER:
                [_baseNetworkWrapper sparkUnregisterPrinter:object object:onResponse];
                break;
            case AT_SPARK_CREATE_JOB:
                [_baseNetworkWrapper sparkCreateJob:object createJobResponse:onResponse];
                break;
            case  AT_SPARK_COMMAND_SEND:
                [_baseNetworkWrapper sparkCommandSend:object commandSendResponse:onResponse];
                break;
            case AT_SPARK_JOB_STATUS:
                [_baseNetworkWrapper sparkJobStatus:object printerJobStatusResponse:onResponse];
                break;
            default:
                break;
        }
    }
    
}

// API that updates the Access Token when expire
//----------------------------------------------
-(void)getAsset:(AssetRequest*)asset assetResponse:(id<SparkResponseDelegate>) onAssetResponse {
    // Call the class that encapsulate the call
    [self callWithUpdateRefreshToken:AT_SPARK_GET_ASSET withObject:asset responde:onAssetResponse] ;
}

-(void)getAssetsAssetsListResponse:(id<SparkResponseDelegate>)onAssetResponse {
    
    [self callWithUpdateRefreshToken:AT_SPARK_GET_ASSETS withObject:nil responde:onAssetResponse] ;
}

-(void)getMemberAssets:(MemberRequest*)member assetsListResponse:(id<SparkResponseDelegate>) onAssetResponse {
    
    [self callWithUpdateRefreshToken:AT_SPARK_GET_MEMBER_ASSETS withObject:member responde:onAssetResponse] ;
}

-(void)getMember:(MemberRequest*)member memberResponse:(id<SparkResponseDelegate>) onMemberResponse {
    [self callWithUpdateRefreshToken:AT_SPARK_GET_MEMBER withObject:member responde:onMemberResponse] ;
}

-(BOOL)isGuestTokenType:(id<SparkResponseDelegate>) onResponse {
    if (SPARK_AUTHORIZATION_TOKEN_TYPE_REGULAR != [[SparkLogicManager sharedInstance] authorizationType]) {
        // auth 2.0 required and not guest token
        
        [onResponse onSparkFailure:SPARK_EXCEPTION_ACCESS_TOKEN_REQUIRED];
        return YES;
    }
    
    return NO;
}

-(void)createAsset:(AssetRequest*)asset assetResponse:(id<SparkResponseDelegate>) onCreateAssetResponse {
    [self callWithUpdateRefreshToken:AT_SPARK_CREATE_ASSET withObject:asset responde:onCreateAssetResponse checkToken:YES];
}

-(void)createFile:(FileRequest*)file filesResponse:(id<SparkResponseDelegate>) onSparkResponse {
    [self callWithUpdateRefreshToken:AT_SPARK_CREATE_FILE withObject:file responde:onSparkResponse checkToken:YES];
}

-(void)registerPrinter:(PrinterRegisterRequest*)printer printerRegisterResponse:(id<SparkResponseDelegate>) onSparkResponse {
     [self callWithUpdateRefreshToken:AT_SPARK_REGISTER_PRINTER withObject:printer responde:onSparkResponse checkToken:YES];
}
     
-(void)unregisterPrinter:(PrinterUnregisterRequest*)printer object:(id<SparkResponseDelegate>) onSparkResponse {
    [self callWithUpdateRefreshToken:AT_SPARK_UNREGISTER_PRINTER withObject:printer responde:onSparkResponse checkToken:YES];
}

-(void)createJob:(CreateJobRequest*) printerJob createJobResponse:(id<SparkResponseDelegate>) onSparkResponse {
    [self callWithUpdateRefreshToken:AT_SPARK_CREATE_JOB withObject:printerJob responde:onSparkResponse checkToken:YES];
}

-(void)commandSend:(CommandSendRequest*)command commandSendResponse:(id<SparkResponseDelegate>) onSparkResponse {
    [self callWithUpdateRefreshToken:AT_SPARK_COMMAND_SEND withObject:command responde:onSparkResponse checkToken:YES];
}

-(void)jobStatus:(PrinterJobStatusRequest*)jobStatus printerJobStatusResponse:(id<SparkResponseDelegate>) onSparkResponse {
    [self callWithUpdateRefreshToken:AT_SPARK_JOB_STATUS withObject:jobStatus responde:onSparkResponse checkToken:YES];
}

-(void)initAndShowWebviewWithParent:(UIViewController*)parent{

    NSMutableString * initialUrl = [NSMutableString string];
    [initialUrl appendString:[Utils getBaseURL]];
    [initialUrl appendString:@"/"];
    [initialUrl appendString:API_AUTHORIZE];
    [initialUrl appendString:@"?"];
    [initialUrl appendString:[NSString stringWithFormat:@"%@=%@", SPARK_LOGIN_REQUEST_PARAM_RESPONSE_TYPE, SPARK_LOGIN_REQUEST_VALUE_RESPONSE_TYPE]];
    [initialUrl appendString:@"&"];
    [initialUrl appendString:[NSString stringWithFormat:@"%@=%@", SPARK_LOGIN_REQUEST_PARAM_CLIENT_ID, [[SparkLogicManager sharedInstance] appKey]]];
    [initialUrl appendString:@"&"];
    
    NSString *replaceCallBackUrl = [SPARK_BOGUS_REDIRECT_URL stringByReplacingOccurrencesOfString:@"[MY-WEB-ADDRESS-FOR-CALLBACK]" withString:SPARK_CALLBACK_SITE_NAME];
    [initialUrl appendString:[NSString stringWithFormat:@"%@=%@", SPARK_LOGIN_REQUEST_PARAM_REDIRECT_URI, replaceCallBackUrl]];

    _webview = [[UIWebView alloc] initWithFrame:parent.view.bounds];

    if ([[SparkLogicManager sharedInstance] debugMode]) {
        NSLog(@"Logging into Spark with URL:%@", initialUrl);
    }

    [parent.view addSubview:_webview];
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:initialUrl]];
    [_webview loadRequest:request];
    [_webview setDelegate:self];
}

-(void)loadURLAuthorizationCode:(NSString*)url{
    
    if ([url length] > 0) {
        NSRange range = [url rangeOfString:@"code="];
        if (range.location  != NSNotFound) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            for (NSString *param in [url componentsSeparatedByString:@"&"]) {
                NSArray *elts = [param componentsSeparatedByString:@"="];
                if([elts count] < 2)
                    continue;
                [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
            }
            
            for (NSString * key in [params allKeys]) {
                if ([key isEqualToString:@"code"]) {
                    AuthCodeRequest * acr = [[AuthCodeRequest alloc] init];
                    acr.autoCode = [params objectForKey:@"code"];
                    
                    [self getAccessToken:acr
                            succsesBlock:_succsesBlock
                            failureBlock:_failBlock];
                }
            }
            
            
            [_webview removeFromSuperview];
            _webview = nil;
        }
    }
}

//-(void)onAfterParsing:(NSDictionary*)json{
//    [[SparkLogicManager sharedInstance] setAccessToken:[json objectForKey:@"access_token"]];
//    [[SparkLogicManager sharedInstance] setRefreshToken:[json objectForKey:@"refresh_token"]];
//    [[SparkLogicManager sharedInstance] setAuthorizationType:SPARK_AUTHORIZATION_TOKEN_TYPE_GUEST];
//    [[SparkLogicManager sharedInstance] setExpiresAt:[[json objectForKey:@"expires_at"] longValue]];
//}

#pragma mark- UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self loadURLAuthorizationCode:[webView.request.URL absoluteString]];
}

@end
