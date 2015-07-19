//
//  UploadFileTask.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 7/5/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSparkRequest.h"
#import "Protocols.h"
#import "FileRequest.h"

@interface UploadFileTask : BaseSparkRequest{
    FileRequest* _fileRequest;
}

-(instancetype)initWithFileRequest:(FileRequest*)file
                           success:(SparkSuccessBlock)success
                           failure:(SparkFailureBlock)failure;
-(void)executeApiCall;

@end
