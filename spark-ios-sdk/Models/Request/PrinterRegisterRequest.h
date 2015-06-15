//
//  PrinterRegisterRequest.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/15/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrinterRegisterRequest : NSObject

@property (nonatomic, strong) NSString * printerName;
@property (nonatomic, strong) NSString * registrationCode;

-(void)printerRegisterRequest:(NSString*) printerName registrationCode:(NSString*) registrationCode;

@end
