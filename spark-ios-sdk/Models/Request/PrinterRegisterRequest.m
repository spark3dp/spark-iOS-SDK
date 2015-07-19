//
//  PrinterRegisterRequest.m
//  spark-ios-sdk
//
//  Created by Autodesk on 6/15/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "PrinterRegisterRequest.h"

@implementation PrinterRegisterRequest


-(void)printerRegisterRequest:(NSString*) printerName registrationCode:(NSString*)registrationCode{
    _printerName = printerName;
    _registrationCode = registrationCode;
}

@end
