//
//  FileRequest.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/15/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "FileRequest.h"

@implementation FileRequest

-(void)fileRequest:(BOOL)zipEnable publicEnable:(BOOL)publicEnable path:(NSString*)path{
    _zipEnable = zipEnable;
    _publicEnable = publicEnable;
    _path = path;
}

@end
