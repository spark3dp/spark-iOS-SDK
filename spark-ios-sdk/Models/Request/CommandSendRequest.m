//
//  CommandSendRequest.m
//  spark-ios-sdk
//
//  Created by Autodesk on 6/15/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "CommandSendRequest.h"

@implementation CommandSendRequest

-(void)createJobRequest:(NSString*)printerID jobID:(NSString*)jobID command:(NSString*)command{
    _printerID = printerID;
    _jobID = jobID;
    _command = command;
}

@end
