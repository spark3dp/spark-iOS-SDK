//
//  SparkLogicManager.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SparkLogicManager : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, strong) NSString * refreshToken;
@property (nonatomic, strong) NSString * appKey;
@property (nonatomic, strong) NSString * appSecret;
@property (nonatomic, strong) NSString * appKeySecretBase64;
@property (nonatomic) NSInteger authorizationType;
@property (nonatomic) BOOL debugMode;
@property (nonatomic) long expiresAt;
@property (nonatomic) NSInteger baseURLType;

+ (SparkLogicManager *)sharedInstance;

- (void)setAppKeySecret:(NSString*)appKey
              appSecret:(NSString*)appSecret
                envType:(NSInteger)envType;


@end
