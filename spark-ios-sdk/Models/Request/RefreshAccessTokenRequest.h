//
//  RefreshAccessTokenRequest.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/14/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefreshAccessTokenRequest : NSObject

@property (nonatomic, strong) NSString * refreshCode;

-(instancetype)initWithRefreshCode:(NSString*)refreshCode;

@end
