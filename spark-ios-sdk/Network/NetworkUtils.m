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
#import <QuartzCore/QuartzCore.h>

@implementation NetworkUtils

typedef enum ActionType
{
    AT_SPARK_GET_ASSET,
    AT_SPARK_GET_ASSETS,
    AT_SPARK_GET_MEMBER_ASSETS,
    AT_SPARK_GET_MEMBER,
    AT_SPARK_CREATE_ASSET,
    AT_SPARK_UPLOAD_FILE,
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

-(void)getRefreshToken:(RefreshAccessTokenRequest*)refreshCode
                success:(SparkSuccessBlock)success
               failure:(SparkFailureBlock)failure {
    
    //[_baseNetworkWrapper sparkGetRefreshToken:refreshCode accessTokenResponse:onRefreshTokenResponse];
}

-(void)callWithUpdateRefreshToken:(ActionType)action
                       withObject:(id)object
                          success:(SparkSuccessBlock)success
                          failure:(SparkFailureBlock)failure {
    // override the flag
    [self callWithUpdateRefreshToken:action withObject:object success:success failure:failure checkToken:NO];
}
     
-(void)callWithUpdateRefreshToken:(ActionType)action
                       withObject:(id)object
                          success:(SparkSuccessBlock)success
                          failure:(SparkFailureBlock)failure
                       checkToken:(BOOL)checkToken {
    
    if (checkToken && [self isGuestTokenTypeSuccess:success failure:failure]) {
        //on guest token type raise error and quit
        return;
    }
    
    if ([Utils needToUpdateAccessToken]){
       
        RefreshAccessTokenRequest * ratr = [[RefreshAccessTokenRequest alloc] initWithRefreshCode:[[SparkLogicManager sharedInstance] refreshToken]];
        
        [self getRefreshToken:ratr success:success failure:failure];
        
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
                [_baseNetworkWrapper sparkGetAsset:object success:success failure:failure];
                break;
            case AT_SPARK_GET_ASSETS:
                [_baseNetworkWrapper sparkGetAssetsSuccess:success failure:failure];
                break;
            case AT_SPARK_GET_MEMBER_ASSETS:
                [_baseNetworkWrapper sparkGetMemberAssets:object success:success failure:failure];
                break;
            case AT_SPARK_GET_MEMBER:
                [_baseNetworkWrapper sparkGetMember:object success:success failure:failure];
                break;
            case AT_SPARK_CREATE_ASSET:
                [_baseNetworkWrapper sparkCreateAsset:object success:success failure:failure];
                break;
            case AT_SPARK_UPLOAD_FILE:
                [_baseNetworkWrapper sparkCreateFile:object success:success failure:failure];
                break;
            case AT_SPARK_REGISTER_PRINTER:
                [_baseNetworkWrapper sparkRegisterPrinter:object success:success failure:failure];
                break;
            case AT_SPARK_UNREGISTER_PRINTER:
                [_baseNetworkWrapper sparkUnregisterPrinter:object success:success failure:failure];
                break;
            case AT_SPARK_CREATE_JOB:
                [_baseNetworkWrapper sparkCreateJob:object success:success failure:failure];
                break;
            case  AT_SPARK_COMMAND_SEND:
                [_baseNetworkWrapper sparkCommandSend:object success:success failure:failure];
                break;
            case AT_SPARK_JOB_STATUS:
                [_baseNetworkWrapper sparkJobStatus:object success:success failure:failure];
                break;
            default:
                break;
        }
    }
    
}

// API that updates the Access Token when expire
//----------------------------------------------
-(void)getAsset:(AssetRequest*)asset
        success:(SparkSuccessBlock)success
        failure:(SparkFailureBlock)failure {
    
    // Call the class that encapsulate the call
    [self callWithUpdateRefreshToken:AT_SPARK_GET_ASSET withObject:asset success:success failure:failure] ;
}

-(void)getAssetsListSuccess:(SparkSuccessBlock)success
                    failure:(SparkFailureBlock)failure {
    
    [self callWithUpdateRefreshToken:AT_SPARK_GET_ASSETS withObject:nil success:success failure:failure] ;
}

-(void)getMemberAssets:(MemberRequest*)member
               success:(SparkSuccessBlock)success
               failure:(SparkFailureBlock)failure {
    
    [self callWithUpdateRefreshToken:AT_SPARK_GET_MEMBER_ASSETS withObject:member success:success failure:failure] ;
}

-(void)getMember:(MemberRequest*)member
         success:(SparkSuccessBlock)success
         failure:(SparkFailureBlock)failure {
    [self callWithUpdateRefreshToken:AT_SPARK_GET_MEMBER withObject:member success:success failure:failure] ;
}

-(BOOL)isGuestTokenTypeSuccess:(SparkSuccessBlock)success
                       failure:(SparkFailureBlock)failure {
    if (SPARK_AUTHORIZATION_TOKEN_TYPE_REGULAR != [[SparkLogicManager sharedInstance] authorizationType]) {
        // auth 2.0 required and not guest token
        
        failure(SPARK_EXCEPTION_ACCESS_TOKEN_REQUIRED);
        return YES;
    }
    
    return NO;
}

-(void)createAsset:(AssetRequest*)asset
           success:(SparkSuccessBlock)success
           failure:(SparkFailureBlock)failure {
    [self callWithUpdateRefreshToken:AT_SPARK_CREATE_ASSET withObject:asset success:success failure:failure checkToken:YES];
}

-(void)uploadFile:(FileRequest*)file
          success:(SparkSuccessBlock)success
          failure:(SparkFailureBlock)failure {
    [self callWithUpdateRefreshToken:AT_SPARK_UPLOAD_FILE withObject:file success:success failure:failure checkToken:YES];
}

-(void)registerPrinter:(PrinterRegisterRequest*)printer
               success:(SparkSuccessBlock)success
               failure:(SparkFailureBlock)failure {
    
     [self callWithUpdateRefreshToken:AT_SPARK_REGISTER_PRINTER withObject:printer success:success failure:failure checkToken:YES];
}
     
-(void)unregisterPrinter:(PrinterUnregisterRequest*)printer
                 success:(SparkSuccessBlock)success
                 failure:(SparkFailureBlock)failure {
    [self callWithUpdateRefreshToken:AT_SPARK_UNREGISTER_PRINTER withObject:printer success:success failure:failure checkToken:YES];
}

-(void)createJob:(CreateJobRequest*) printerJob
         success:(SparkSuccessBlock)success
         failure:(SparkFailureBlock)failure  {
    [self callWithUpdateRefreshToken:AT_SPARK_CREATE_JOB withObject:printerJob success:success failure:failure checkToken:YES];
}

-(void)commandSend:(CommandSendRequest*)command
           success:(SparkSuccessBlock)success
           failure:(SparkFailureBlock)failure{
    [self callWithUpdateRefreshToken:AT_SPARK_COMMAND_SEND withObject:command success:success failure:failure checkToken:YES];
}

-(void)jobStatus:(PrinterJobStatusRequest*)jobStatus
         success:(SparkSuccessBlock)success
         failure:(SparkFailureBlock)failure {
    [self callWithUpdateRefreshToken:AT_SPARK_JOB_STATUS withObject:jobStatus success:success failure:failure checkToken:YES];
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

    _bgView = [[UIView alloc] initWithFrame:parent.view.bounds];
    [_bgView setBackgroundColor:[UIColor blackColor]];
    [_bgView setAlpha:0.0];
    [parent.view addSubview:_bgView];

    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 350)];
    _webview.center = parent.view.center;
    _webview.layer.borderColor = [UIColor blackColor].CGColor;
    _webview.layer.borderWidth = 3.0f;

    if ([[SparkLogicManager sharedInstance] debugMode]) {
        NSLog(@"Logging into Spark with URL:%@", initialUrl);
    }

    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:initialUrl]];
    [_webview loadRequest:request];
    [_webview setDelegate:self];
    _webview.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [parent.view addSubview:_webview];
    
    [UIView animateWithDuration:0.3 animations:^{
        [_bgView setAlpha:0.7];
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.8
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _webview.transform = CGAffineTransformIdentity;
                         } completion:nil];
        
    }];
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
            
            [_bgView removeFromSuperview];
            [_webview removeFromSuperview];
            _webview = nil;
        }
    }
}

#pragma mark- UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self loadURLAuthorizationCode:[webView.request.URL absoluteString]];
}

@end
