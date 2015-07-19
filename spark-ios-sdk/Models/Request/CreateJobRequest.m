//
//  CreateJobRequest.m
//  spark-ios-sdk
//
//  Created by Autodesk on 6/15/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "CreateJobRequest.h"

@implementation CreateJobRequest

-(void)createJobRequest:(NSString*)printerID printableURL:(NSString*) printableURL{
    _printerID = printerID;
    _printableURL = printableURL;
}

@end
