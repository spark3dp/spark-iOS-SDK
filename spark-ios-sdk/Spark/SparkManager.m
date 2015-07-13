//
//  SparkManager.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "SparkManager.h"
#import "SparkLogicManager.h"
#import "Utils.h"
#import "Constants.h"
#import "SparkAuthentication.h"
#import "SparkDrive.h"


@implementation SparkManager

static SparkManager *sharedInstance = nil;

+ (SparkManager *)sharedInstance {
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[SparkManager alloc] init];
    });
    
    return sharedInstance;
}




/**
 * Enable Spark Debug Mode
 * @param debugMode Enabel the debug mode.
 *                  Debug messages appear in the log
 *
 */

-(void)setDebugMode:(BOOL) debugMode {
    [[SparkLogicManager sharedInstance] setDebugMode:debugMode];
}

/**
 * Init Spark API - Use this method the init the Spark API with the app key & app secret
 *
 * @param appKey Spark App Key from the dev portal
 * @param appSecret Spark App Secret from the dev portal
 * @param envType enviroment mode production or dev
 */
-(void)initKey:(NSString*)appKey appSecret:(NSString*) appSecret envType:(int)envType {
    
    // set the keys
    [[SparkLogicManager sharedInstance] setAppKeySecret:appKey appSecret:appSecret envType:envType];
    
    // check that all configured well
    if ([self checkConfiguration]) {
        
        // create network utils for the api calls
        self.networkUtils = [[NetworkUtils alloc] init];
        
        // init the sub variables for api calls
        [[SparkAuthentication sharedInstance] setNetworkUtils:self.networkUtils];
        
        [[SparkDrive sharedInstance] setNetworkUtils:self.networkUtils];
    }
}


/**  Check Pre Configuration before running spark API calls.
 *
 * @return true if the configuration is valid.
 * valid configuration when is when Spark.init is called
 */
-(BOOL)checkPreConfiguration{
    // check for existance of the access tokens
    if ([[[SparkLogicManager sharedInstance] accessToken] isEqualToString:@""])
    {
        NSLog(@"%@", SPARK_EXCEPTION_CONFIGURATION_ERROR);
        NSLog(@"%@", SPARK_EXCEPTION_CONFIGURATION_GET_TOKEN);
        NSLog(@"%@", SPARK_EXCEPTION_SPARK_TEAM);
        
        return NO;
    }
    
    // Check pre Acces token
    if (![self checkPreAccessToken])
    {
        return NO;
    }
    
    return YES;
}

/**  Check Pre Access Token before running spark API calls.
 *
 * @return true if the configuration is valid.
 * valid configuration when is when Accesstoken available.
 */
-(BOOL)checkPreAccessToken{
    
    // check for the init
    if ([[SparkManager sharedInstance] networkUtils] == nil)
    {
        // init not called
        NSLog(@"%@", SPARK_EXCEPTION_CONFIGURATION_ERROR);
        NSLog(@"%@", SPARK_EXCEPTION_CONFIGURATION_ADD_INIT);
        NSLog(@"%@", SPARK_EXCEPTION_SPARK_TEAM);
        
        return NO;
    }
    
    return YES;
}

-(BOOL)checkConfiguration {
    
    // check for permissions
    if (![Utils checkForPermissions]){
        // permissions not found
        NSLog(@"%@", SPARK_EXCEPTION_PERMISSIONS_ERROR);
        NSLog(@"%@", SPARK_EXCEPTION_PERMISSION_INTERNET);
        NSLog(@"%@", SPARK_EXCEPTION_PERMISSION_NETWORK);
        NSLog(@"%@", SPARK_EXCEPTION_SPARK_TEAM);
        
        return NO;
    }
    
    //check for valid api keys
    if ([[SparkLogicManager sharedInstance] appKey] == nil){
        // app key not found
        NSLog(@"%@", SPARK_EXCEPTION_PERMISSIONS_ERROR);
        NSLog(@"%@", SPARK_EXCEPTION_CONFIGURATION_APPKEY);
        NSLog(@"%@", SPARK_EXCEPTION_SPARK_TEAM);
        
        return NO;
    }
    
    return YES;
}

@end
