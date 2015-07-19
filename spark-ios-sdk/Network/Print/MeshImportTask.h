//
//  MeshImportTask.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 7/8/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
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
