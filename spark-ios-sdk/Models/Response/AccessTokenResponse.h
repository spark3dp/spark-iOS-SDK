//
//  AccessTokenResponse.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 6/28/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessTokenResponse : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, strong) NSString * refreshToken;
@property (nonatomic, strong) NSString * expiresIn;
@property (nonatomic, strong) NSString * expiresAt;

@end
