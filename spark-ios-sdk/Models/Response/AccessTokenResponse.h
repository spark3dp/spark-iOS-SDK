//
//  AccessTokenResponse.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/28/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessTokenResponse : NSObject

@property (nonatomic, strong) NSString * access_token;
@property (nonatomic, strong) NSString * refresh_token;
@property (nonatomic, strong) NSString * expires_in;
@property (nonatomic, strong) NSString * expires_at;

@end
