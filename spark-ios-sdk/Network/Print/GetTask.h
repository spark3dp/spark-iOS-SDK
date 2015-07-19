//
//  GetTask.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 7/9/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseSparkRequest.h"
#import "Protocols.h"

@interface GetTask : BaseSparkRequest
{
    NSString * _taskId;
}

-(instancetype)initWithTaskId:(NSString*)taskId
                      success:(SparkSuccessBlock)success
                      failure:(SparkFailureBlock)failure;

-(void)executeApiCall;

@end
