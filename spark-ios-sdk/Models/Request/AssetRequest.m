//
//  AssetRequest.m
//  spark-ios-sdk
//
//  Created by Autodesk on 6/14/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "AssetRequest.h"

@implementation AssetRequest


-(void)assetRequest:(NSString*)assetName assetDescription:(NSString*)assetDescription assetTags:(NSString*)assetTags{
    _assetName = assetName;
    _assetDescription = assetDescription;
    _assetTags = assetTags;
}

-(NSString*)toJson{
    NSMutableDictionary * json = [[NSMutableDictionary alloc] init];
    [json setObject:self.assetName forKey:@"asset_name"];
    [json setObject:self.assetDescription forKey:@"asset_description"];
    [json setObject:self.assetTags forKey:@"asset_tags"];
    
    NSError *error;
    NSString *jsonString = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
