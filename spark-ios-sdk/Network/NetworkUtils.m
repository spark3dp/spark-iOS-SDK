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

@implementation NetworkUtils


-(instancetype)init{
    self = [self init];
    if (self) {
        baseNetworkWrapper = [[BaseNetworkWrapper alloc] init];
    }
    
    return self;
}

// API with no need of Access Token
//----------------------------------

+(void)getGuestToken(final ISparkResponse<AccessTokenResponse> onGuestTokenResponse) {
    // Call the class that encapsulate the call
    baseNetworkWrapper.sparkGetGuestToken(onGuestTokenResponse);
}

+(void)getAccessToken:(AuthCodeRequest*)authCode, final ISparkResponse<AccessTokenResponse> onAccessTokenResponse) {
    // Call the class that encapsulate the call
    mWrapper.sparkGetAccessToken(authCode, onAccessTokenResponse);
}

+(void)getAuthorizationCode(final ISparkResponse<AccessTokenResponse> onAccessTokenResponse) {
    initAndShowWebview(onAccessTokenResponse);
}

+(void)getRefreshToken:(RefreshAccessTokenRequest*)refreshCode, final ISparkResponse<AccessTokenResponse> onRefreshTokenResponse) {
    
    mWrapper.sparkGetRefreshToken(refreshCode, onRefreshTokenResponse);
}


+(void)callWithUpdateRefreshToken(final Runnable action, final ISparkResponse<?> onResponse) {
    // override the flag
    callWithUpdateRefreshToken(action, onResponse, false);
}

+(void)callWithUpdateRefreshToken(final Runnable action, final ISparkResponse<?> onResponse, boolean checkToken) {
    
    if (checkToken && isGuestTokenType(onResponse)) {
        //on guest token type raise error and quit
        return;
    }
    
    if (Utils.needToUpdateAccessToken()) {
        // update call
        getRefreshToken(new RefreshAccessTokenRequest(MemoryManager.getInstance().getRefreshToken()), new ISparkResponse<AccessTokenResponse>() {
            @Override
            public void onSparkSuccess(AccessTokenResponse responseObject) {
                
                action.run();
            }
            
            @Override
            public void onSparkFailure(String errorMessage) {
                
                onResponse.onSparkFailure(errorMessage);
                
                // on refresh error, try to open the login screen again
                initAndShowWebview(new ISparkResponse<AccessTokenResponse>() {
                    @Override
                    public void onSparkSuccess(AccessTokenResponse responseObject) {
                        
                        // on success, call the action to perform
                        action.run();
                    }
                    
                    @Override
                    public void onSparkFailure(String errorMessage) {
                        
                    }
                });
                
                
            }
        });
        
    } else {
        // regular call
        action.run();
    }
    
}

// API that updates the Access Token when expire
//----------------------------------------------
+(void)getAsset:(AssetRequest*)asset assetResponse:(id<SparkResponseDelegate>) onAssetResponse {
    // Call the class that encapsulate the call
    
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkGetAsset(asset, onAssetResponse);
            
        }
    }, onAssetResponse);
    
}

+(void)getAssetsAssetsListResponse:(id<SparkResponseDelegate>)onAssetResponse {
    
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkGetAssets(onAssetResponse);
            
        }
    }, onAssetResponse);
}

+(void)getMemberAssets:(MemberRequest*)member assetsListResponse:(id<SparkResponseDelegate>) onAssetResponse {
    
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkGetMemberAssets(member,onAssetResponse);
            
        }
    }, onAssetResponse,true);
}

+(void)getMember:(MemberRequest*)member memberResponse:(id<SparkResponseDelegate>) onMemberResponse {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkGetMember(member, onMemberResponse);
            
        }
    }, onMemberResponse);
}

+(BOOL)isGuestTokenType:(id<SparkResponseDelegate>) onResponse {
    if (Constants.SPARK_AUTHORIZATION_TOKEN_TYPE_REGULAR != MemoryManager.getInstance().getAuthorizationType()) {
        // auth 2.0 required and not guest token
        onResponse.onSparkFailure(Constants.SPARK_EXCEPTION_ACCESS_TOKEN_REQUIRED);
        return true;
    }
    
    return false;
}

+(void)createAsset:(AssetRequest*)asset assetResponse:(id<SparkResponseDelegate>) onCreateAssetResponse {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkCreateAsset(asset, onCreateAssetResponse);
            
        }
    }, onCreateAssetResponse, true);
}

+(void)createFile:(FileRequest*)file filesResponse:(id<SparkResponseDelegate>) onSparkResponse {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkCreateFile(file, onSparkResponse);
            
        }
    }, onSparkResponse, true);
}


+(void)registerPrinter:(PrinterRegisterRequest*)printer printerRegisterResponse:(id<SparkResponseDelegate>) onSparkResponse {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkRegisterPrinter(printer, onSparkResponse);
            
        }
    }, onSparkResponse, true);
}

+(void)unregisterPrinter:(PrinterUnregisterRequest*)printer final ISparkResponse<Object> onSparkResponse) {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkUnregisterPrinter(printer, onSparkResponse);
            
        }
    }, onSparkResponse, true);
}

+(void)createJob:(CreateJobRequest*) printerJob, final ISparkResponse<CreateJobResponse> onSparkResponse) {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkCreateJob(printerJob, onSparkResponse);
            
        }
    }, onSparkResponse, true);
}

+(void)commandSend:(CommandSendRequest*)command final ISparkResponse<CommandSendResponse> onSparkResponse) {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkCommandSend(command, onSparkResponse);
            
        }
    }, onSparkResponse, true);
}

+(void)jobStatus:(PrinterJobStatusRequest*)jobStatus final ISparkResponse<PrinterJobStatusResponse> onSparkResponse) {
    callWithUpdateRefreshToken(new Runnable() {
        @Override
        public void run() {
            
            mWrapper.sparkJobStatus(jobStatus,onSparkResponse);
            
        }
    }, onSparkResponse, true);
}

-(void)initAndShowWebview(final ISparkResponse<AccessTokenResponse> onAccessTokenResponse) {
    //        final ProgressDialog pd = new ProgressDialog(activity);
    //        pd.setIndeterminate(true);
    //        pd.show();
    
    Uri.Builder builder = new Uri.Builder();
    builder.scheme(Constants.SPARK_SCHEME)
    .authority(Utils.getBaseURL())
    .appendPath(Constants.API_AUTHORIZE)
    .appendQueryParameter(Constants.SPARK_LOGIN_REQUEST_PARAM_RESPONSE_TYPE, Constants.SPARK_LOGIN_REQUEST_VALUE_RESPONSE_TYPE)
    .appendQueryParameter(Constants.SPARK_LOGIN_REQUEST_PARAM_CLIENT_ID, MemoryManager.getInstance().getAppKey())
    .appendQueryParameter(Constants.SPARK_LOGIN_REQUEST_PARAM_REDIRECT_URI, Constants.SPARK_BOGUS_REDIRECT_URL);
    Uri uri = builder.build();
    final String initialUrl = URLDecoder.decode(uri.toString());
    
    
    LoginWebView webView = new LoginWebView(mContext);
    
    if (MemoryManager.getInstance().getDebugMode()) {
        DebugModeUtils.logDebugMessage(TAG, "Logging into Spark with URL:", initialUrl);
    }
    
    webView.loadUrl(initialUrl);
    
    final Dialog dialog = webView.getDialog(mContext);
    dialog.show();
    
    View mainView = View.inflate(mContext,R.layout.layout_login_dialog,null);
    RelativeLayout relativeWrapper = (RelativeLayout) mainView.findViewById(R.id.realtive_webview_wrapper);
    RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
    relativeWrapper.addView(webView, lp);
    
    dialog.setContentView(mainView);
    
    webView.setWebViewAccessInvoke(new IOnWebViewAccessInvoke() {
        @Override
        public void onWebViewAccessInvoke(String url) {
            
            dialog.dismiss();
            
            loadURLAuthorizationCode(url, onAccessTokenResponse);
            
        }
    });
    
}

-(void)loadURLAuthorizationCode:(NSString*)url ISparkResponse<AccessTokenResponse> onAccessTokenResponse) {
    
    if (url.length() > 0) {
        Uri returnURL = Uri.parse(url);
        if (returnURL != null) {
            String code = returnURL.getQueryParameter(Constants.SPARK_LOGIN_REQUEST_VALUE_RESPONSE_TYPE);
            if (code != null) {
                getAccessToken(new AuthCodeRequest(code), onAccessTokenResponse);
            }
        }
    }
    
}
}

@end
