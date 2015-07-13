//
//  SparkDrive.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "SparkDrive.h"
#import "SparkManager.h"

@implementation SparkDrive

static SparkDrive *sharedInstance = nil;

+ (SparkDrive *)sharedInstance {
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[SparkDrive alloc] init];
    });
    
    return sharedInstance;
}

/** upload file and upload it to the server.
 *
 * @param fileRequest New file to create, filled with file data and path.
 * @param sucssesBlock File response object.
 * @param failureBlock error string.
 */
-(void)sparkUploadFile:(FileRequest*)fileRequest
           succesBlock:(SparkSuccessBlock)sucssesBlock
               failure:(SparkFailureBlock)failureBlock{
    
     if ([[SparkManager sharedInstance] checkPreConfiguration]) {
         
         [self.networkUtils uploadFile:fileRequest
                               success:sucssesBlock
                               failure:failureBlock];
    }
}


/** upload file and upload it to the server.
 *
 * @param meshImportRequest see obj.
 * @param succesBlock NSDictionary response object.
 * @param failureBlock error string.
 */
-(void) sparkMeshImport:(MeshImportRequest*)meshImportRequest
            succesBlock:(SparkSuccessBlock)succesBlock
                failure:(SparkFailureBlock)failureBlock{
    
    if ([[SparkManager sharedInstance] checkPreConfiguration]) {
        
        [self.networkUtils meshImport:meshImportRequest
                              success:succesBlock
                              failure:failureBlock];
    }
}

@end
