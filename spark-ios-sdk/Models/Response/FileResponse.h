//
//  FileResponse.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileResponse : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * md5sum;
@property (nonatomic, strong) NSString * fileId;
@property (nonatomic, strong) NSString * publicUrl;
@property (nonatomic, strong) NSArray * files;

-(NSString*)toString;

@end
