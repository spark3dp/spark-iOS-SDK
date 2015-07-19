//
//  PrinterRegisterRequest.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/15/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrinterRegisterRequest : NSObject

@property (nonatomic, strong) NSString * printerName;
@property (nonatomic, strong) NSString * registrationCode;

-(void)printerRegisterRequest:(NSString*) printerName registrationCode:(NSString*) registrationCode;

@end
