//
//  AssetRequest.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "AssetRequest.h"

@implementation AssetRequest


-(void)assetRequest:(NSString*)assetName assetDescription:(NSString*)assetDescription assetTags:(NSString*)assetTags{
    _asset_name = assetName;
    _asset_description = assetDescription;
    _asset_tags = assetTags;
}

-(NSString*)toJson{
    NSMutableDictionary * json = [[NSMutableDictionary alloc] init];
    [json setObject:self.asset_name forKey:@"asset_name"];
    [json setObject:self.asset_description forKey:@"asset_description"];
    [json setObject:self.asset_tags forKey:@"asset_tags"];
    
    NSError *error;
    NSString *jsonString = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}


//    
//    NSString *bodyData = [NSString stringWithFormat:@"user=%@", jsonString];
//    NSData * encodeData = [bodyData dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSString *urlString = [NSString stringWithFormat:@"%@UserInsertServlet", SERVER_URL] ;
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"URL: %@",url);
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:20.0];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:encodeData];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               
//                               [self hideLoadingIndicator];
//                               
//                               if (error) {
//                                   [self showErrorMessage];
//                                   return ;
//                               }
//                               
//                               NSString* encodeRespose = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                           }];
//}

@end
