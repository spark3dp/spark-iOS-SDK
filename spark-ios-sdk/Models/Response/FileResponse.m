//
//  FileResponse.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 7/5/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "FileResponse.h"

@implementation FileResponse

-(NSString*)toString{
    NSMutableString * mstring = [NSMutableString stringWithFormat:@"name: %@\nmd5sum: %@\nfileId: %@\npublicUrl: %@", self.name, self.md5sum, self.fileId, self.publicUrl];
    return mstring;
}

@end
