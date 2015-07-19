//
//  CommandSendRequest.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/15/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandSendRequest : NSObject

@property (nonatomic, strong) NSString * printerID;
@property (nonatomic, strong) NSString * jobID;
@property (nonatomic, strong) NSString * command;

-(void)createJobRequest:(NSString*)printerID jobID:(NSString*)jobID command:(NSString*)command;

@end
