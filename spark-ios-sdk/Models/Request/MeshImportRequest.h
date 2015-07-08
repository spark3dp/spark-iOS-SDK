//
//  MeshImportRequest.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/8/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
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
