//
//  CreateJobRequest.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/15/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "CreateJobRequest.h"

@implementation CreateJobRequest

-(void)createJobRequest:(NSString*)printerID printableURL:(NSString*) printableURL{
    _printerID = printerID;
    _printableURL = printableURL;
}

@end
