//
//  UploadFileTask.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
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
