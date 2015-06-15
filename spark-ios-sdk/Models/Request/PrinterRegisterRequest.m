//
//  PrinterRegisterRequest.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/15/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "PrinterRegisterRequest.h"

@implementation PrinterRegisterRequest


-(void)printerRegisterRequest:(NSString*) printerName registrationCode:(NSString*)registrationCode{
    _printerName = printerName;
    _registrationCode = registrationCode;
}

@end
