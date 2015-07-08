//
//  MeshImportRequest.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/8/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "MeshImportRequest.h"

@implementation MeshImportRequest

-(instancetype)initWithFileId:(NSString*)fileId
                          name:(NSString*)name
                     transfrom:(NSString*)transfrom
              isGenerateVisual:(BOOL)generateVisual{
    self = [super init];
   
    if(self){
        self.fileId = fileId;
        self.name = name;
        self.transform = transfrom;
        self.generateVisual = generateVisual;
    }
    
    return self;
}
@end
