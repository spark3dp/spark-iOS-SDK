//
//  MeshImportRequest.h
//  Spark-sdk-demo
//
//  Created by Autodesk on 7/8/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeshImportRequest : NSObject

@property (nonatomic, strong) NSString * fileId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * transform;
@property (nonatomic) BOOL generateVisual;

-(instancetype)initWithFileId:(NSString*)fileId
                          name:(NSString*)name
                     transfrom:(NSString*)transfrom
              isGenerateVisual:(BOOL)generateVisual;
@end
