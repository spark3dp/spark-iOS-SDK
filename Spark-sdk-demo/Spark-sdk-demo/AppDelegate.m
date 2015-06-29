//
//  AppDelegate.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/25/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"
#import "SparkManager.h"

#define SPARK_API_KEY @"mbrTS20Y8BFH7a0O3484B1QjvJQ93tgp"
#define SPARK_API_SECRET @"s0PAMowXbAffpNvG"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Use init with keys in case of app + secret
    NSString *key = SPARK_API_KEY;
    NSString *secret = SPARK_API_SECRET;
    
    [[SparkManager sharedInstance] initKey:key appSecret:secret envType:SPARK_ENV_TYPE_SANBOX];
    [[SparkManager sharedInstance] setDebugMode:YES];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
