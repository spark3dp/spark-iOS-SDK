
//
//  SparkSession.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/25/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "SparkSession.h"
#import "SparkLogicManager.h"

@implementation SparkSession

-(instancetype)initAccessToken:(NSString *) accessToken
                  refreshToken:(NSString *) refreshToken
             authorizationType:(NSInteger) authorizationType{

    self = [super init];
    if (self) {
        self.accessToken = accessToken;
        self.refreshToken = refreshToken;
        self.authorizationType = authorizationType;
    }
    return self;
}

+(SparkSession*)getActiveSession{
    SparkSession * session = [[SparkSession alloc] initAccessToken:[[SparkLogicManager sharedInstance] accessToken]
                                                      refreshToken:[[SparkLogicManager sharedInstance] refreshToken]
                                                 authorizationType:[[SparkLogicManager sharedInstance] authorizationType]];
    return session;
}

@end
