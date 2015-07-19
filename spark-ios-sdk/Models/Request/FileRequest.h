//
//  FileRequest.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/15/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileRequest : NSObject

@property (nonatomic) BOOL zipEnable;
@property (nonatomic) BOOL publicEnable;
@property (nonatomic, strong) NSString * path;
@property (nonatomic, strong) NSData* fileData;

-(instancetype)initWithFileRequest:(BOOL)zipEnable publicEnable:(BOOL)publicEnable path:(NSString*)path fileData:(NSData*)fileData;
@end
