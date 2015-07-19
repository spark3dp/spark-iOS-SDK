//
//  FileResponse.m
//  Spark-sdk-demo
//
//  Created by Autodesk on 7/5/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "FileResponse.h"

@implementation FileResponse

-(NSString*)toString{
    NSMutableString * mstring = [NSMutableString stringWithFormat:@"name: %@\nmd5sum: %@\nfileId: %@\npublicUrl: %@", self.name, self.md5sum, self.fileId, self.publicUrl];
    return mstring;
}

@end
