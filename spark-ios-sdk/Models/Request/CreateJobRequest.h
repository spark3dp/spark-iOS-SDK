//
//  CreateJobRequest.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/15/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateJobRequest : NSObject

@property (nonatomic, strong) NSString * printerID;
@property (nonatomic, strong) NSString * printableURL;

-(void)createJobRequest:(NSString*)printerID printableURL:(NSString*) printableURL;
@end
