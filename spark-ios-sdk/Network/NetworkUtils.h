//
//  NetworkUtils.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseNetworkWrapper.h"

@interface NetworkUtils : NSObject <UIWebViewDelegate>{
    UIWebView * _webview;
    UIView * _bgView;
    SparkAuthenticationSuccessBlock _succsesBlock;
    SparkAuthenticationFailureBlock _failBlock;
}

@property (nonatomic, strong) BaseNetworkWrapper * baseNetworkWrapper;

-(void)getGuestToken:(SparkAuthenticationSuccessBlock)succsesBlock failure:(SparkAuthenticationFailureBlock)failBlock;
-(void)getAuthorizationCode:(SparkAuthenticationSuccessBlock)succsesBlock
                    failure:(SparkAuthenticationFailureBlock)failBlock
       parentViewController:(UIViewController*)parent;

@end
