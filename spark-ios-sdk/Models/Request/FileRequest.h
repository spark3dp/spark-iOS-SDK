//
//  FileRequest.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/15/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileRequest : NSObject

@property (nonatomic) BOOL zipEnable;
@property (nonatomic) BOOL publicEnable;
@property (nonatomic, strong) NSString * path;

-(void)fileRequest:(BOOL)zipEnable publicEnable:(BOOL)publicEnable path:(NSString*)path;
@end
