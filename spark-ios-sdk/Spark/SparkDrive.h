//
//  SparkDrive.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "NetworkUtils.h"

@interface SparkDrive : NSObject

@property (nonatomic, strong) NetworkUtils * networkUtils;

+ (SparkDrive *)sharedInstance;
-(void)sparkUploadFile:(FileRequest*) fileRequest
           succesBlock:(SparkDriveSuccessBlock)sucssesBlock
               failure:(SparkDriveFailureBlock)failureBlock;
@end
