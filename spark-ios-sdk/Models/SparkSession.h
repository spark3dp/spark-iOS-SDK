//
//  SparkSession.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/25/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SparkSession : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, strong) NSString * refreshToken;
@property (nonatomic) NSInteger authorizationType;

-(instancetype)initAccessToken:(NSString *) accessToken
                  refreshToken:(NSString *) refreshToken
             authorizationType:(NSInteger) authorizationType;

+(SparkSession*)getActiveSession;

@end
