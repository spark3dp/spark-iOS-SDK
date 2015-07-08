//
//  MeshImportTask.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/8/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSparkRequest.h"
#import "Protocols.h"
#import "MeshImportRequest.h"

@interface MeshImportTask : BaseSparkRequest
{
    MeshImportRequest * _meshImportRequest;
}

-(instancetype)initWithMeshImportRequest:(MeshImportRequest*)meshImportRequest
                                 success:(SparkSuccessBlock)success
                                 failure:(SparkFailureBlock)failure;

-(void)executeApiCall;

@end
