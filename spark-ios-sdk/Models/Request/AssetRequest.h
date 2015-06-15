//
//  AssetRequest.h
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetRequest : NSObject

@property (nonatomic, strong) NSString * asset_name;
@property (nonatomic, strong) NSString * asset_description;
@property (nonatomic, strong) NSString * asset_tags;

-(void)assetRequest:(NSString*)assetName assetDescription:(NSString*)assetDescription assetTags:(NSString*)assetTags;
-(NSString*)toJson;

@end
