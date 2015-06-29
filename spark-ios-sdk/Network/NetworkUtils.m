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
    [_baseNetworkWrapper sparkGetGuestToken:succsesBlock failure:failBlock];
}

-(void)getAccessToken:(AuthCodeRequest*)authCode accessTokenResponse:(id<SparkResponseDelegate>) onAccessTokenResponse {
    // Call the class that encapsulate the call
    [_baseNetworkWrapper sparkGetAccessToken:authCode accessTokenResponse:onAccessTokenResponse];
}

-(void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock {
    [self initAndShowWebview:succsesBlock failure:failBlock];
}

-(void)getRefreshToken:(RefreshAccessTokenRequest*)refreshCode accessTokenResponse:(id<SparkResponseDelegate>) onRefreshTokenResponse {
    
    [_baseNetworkWrapper sparkGetRefreshToken:refreshCode accessTokenResponse:onRefreshTokenResponse];
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

-(void)initAndShowWebview:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock{
    //        final ProgressDialog pd = new ProgressDialog(activity);
    //        pd.setIndeterminate(true);
    //        pd.show();
    
//    Uri.Builder builder = new Uri.Builder();
//    builder.scheme(Constants.SPARK_SCHEME)
//    .authority(Utils.getBaseURL())
//    .appendPath(Constants.API_AUTHORIZE)
//    .appendQueryParameter(Constants.SPARK_LOGIN_REQUEST_PARAM_RESPONSE_TYPE, Constants.SPARK_LOGIN_REQUEST_VALUE_RESPONSE_TYPE)
//    .appendQueryParameter(Constants.SPARK_LOGIN_REQUEST_PARAM_CLIENT_ID, MemoryManager.getInstance().getAppKey())
//    .appendQueryParameter(Constants.SPARK_LOGIN_REQUEST_PARAM_REDIRECT_URI, Constants.SPARK_BOGUS_REDIRECT_URL);
//    Uri uri = builder.build();
//    final String initialUrl = URLDecoder.decode(uri.toString());
//    
//    
//    LoginWebView webView = new LoginWebView(mContext);
//    
//    if (MemoryManager.getInstance().getDebugMode()) {
//        DebugModeUtils.logDebugMessage(TAG, "Logging into Spark with URL:", initialUrl);
//    }
//    
//    webView.loadUrl(initialUrl);
//    
//    final Dialog dialog = webView.getDialog(mContext);
//    dialog.show();
//    
//    View mainView = View.inflate(mContext,R.layout.layout_login_dialog,null);
//    RelativeLayout relativeWrapper = (RelativeLayout) mainView.findViewById(R.id.realtive_webview_wrapper);
//    RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
//    relativeWrapper.addView(webView, lp);
//    
//    dialog.setContentView(mainView);
//    
//    webView.setWebViewAccessInvoke(new IOnWebViewAccessInvoke() {
//        @Override
//        public void onWebViewAccessInvoke(String url) {
//            
//            dialog.dismiss();
//            
//            loadURLAuthorizationCode(url, onAccessTokenResponse);
//            
//        }
//    });
}

-(void)loadURLAuthorizationCode:(NSString*)url accessTokenResponse:(id<SparkResponseDelegate>) onAccessTokenResponse {
    
//    if (url.length() > 0) {
//        Uri returnURL = Uri.parse(url);
//        if (returnURL != null) {
//            String code = returnURL.getQueryParameter(SPARK_LOGIN_REQUEST_VALUE_RESPONSE_TYPE);
//            if (code != null) {
//                getAccessToken(new AuthCodeRequest(code), onAccessTokenResponse);
//            }
//        }
//    }
}

@end
