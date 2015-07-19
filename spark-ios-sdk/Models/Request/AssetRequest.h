//
//  AssetRequest.h
//  spark-ios-sdk
//
//  Created by Autodesk on 6/14/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetRequest : NSObject

@property (nonatomic, strong) NSString * assetName;
@property (nonatomic, strong) NSString * assetDescription;
@property (nonatomic, strong) NSString * assetTags;

-(void)assetRequest:(NSString*)assetName assetDescription:(NSString*)assetDescription assetTags:(NSString*)assetTags;
-(NSString*)toJson;

@end
