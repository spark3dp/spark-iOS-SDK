//
//  SparkManager.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkUtils.h"

@interface SparkManager : NSObject

@property (nonatomic, strong) NetworkUtils * networkUtils;

+ (SparkManager *)sharedInstance;
- (void)initKey:(NSString*)appKey appSecret:(NSString*) appSecret envType:(int) envType;
- (void)setDebugMode:(BOOL)debugMode;
- (BOOL)checkPreAccessToken;
- (BOOL)checkPreConfiguration;

@end
