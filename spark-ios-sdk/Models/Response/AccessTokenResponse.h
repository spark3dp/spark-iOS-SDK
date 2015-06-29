//
//  AccessTokenResponse.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/28/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessTokenResponse : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, strong) NSString * refreshToken;
@property (nonatomic, strong) NSString * expiresIn;
@property (nonatomic, strong) NSString * expiresAt;

@end