//
//  SparkDrive.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 7/5/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "NetworkUtils.h"

@interface SparkDrive : NSObject

@property (nonatomic, strong) NetworkUtils * networkUtils;

+ (SparkDrive *)sharedInstance;

- (void)sparkUploadFile:(FileRequest*) fileRequest
           succesBlock:(SparkSuccessBlock)sucssesBlock
               failure:(SparkFailureBlock)failureBlock;

-(void) sparkMeshImport:(MeshImportRequest*)meshImportRequest
            succesBlock:(SparkSuccessBlock)succesBlock
                failure:(SparkFailureBlock)failureBlock;
@end
