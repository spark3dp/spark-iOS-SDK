//
//  SparkLogicManager.m
//  spark-ios-sdk
//
//  Created by Tomer Har Yoffi on 6/14/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "SparkLogicManager.h"
#import "Constants.h"

@implementation SparkLogicManager


static SparkLogicManager *sharedInstance = nil;

+ (SparkLogicManager *)sharedInstance {
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[SparkLogicManager alloc] init];
    });
    
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self loadSettings];
    }
    return self;
}

-(void)loadSettings{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [defaults objectForKey:SHARED_PREFERENCE_ACCESS_TOKEN];
    self.refreshToken = [defaults objectForKey:SHARED_PREFERENCE_REFRESH_TOKEN];
    self.appKey = [defaults objectForKey:SHARED_PREFERENCE_APP_KEY];
    self.appSecret = [defaults objectForKey:SHARED_PREFERENCE_APP_SECRET];
    self.appKeySecretBase64 = [defaults objectForKey:SHARED_PREFERENCE_APP_KEY_SECRET_BASE64];
    self.authorizationType = [defaults integerForKey:SHARED_PREFERENCE_AUTHORIZATION_TYPE];
    self.debugMode = [defaults boolForKey:SHARED_PREFERENCE_DEBUG_MODE];
    self.expiresAt = [[defaults objectForKey:SHARED_PREFERENCE_EXPIRES_AT] longValue];
    self.baseURLType = [defaults integerForKey:SHARED_PREFERENCE_BASE_URL];
}

-(void)setAccessToken:(NSString*)accessToken {
    self.accessToken = accessToken;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.accessToken forKey:SHARED_PREFERENCE_ACCESS_TOKEN];
    [defaults synchronize];
}

-(void)setRefreshToken:(NSString*) refreshToken {
    self.refreshToken = refreshToken;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.refreshToken forKey:SHARED_PREFERENCE_REFRESH_TOKEN];
    [defaults synchronize];
}

-(void)setAppKey:(NSString*) appKey {
    self.appKey = appKey;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.appKey forKey:SHARED_PREFERENCE_APP_KEY];
    [defaults synchronize];
}

-(void)setAppSecret:(NSString*) appSecret {
    self.appSecret = appSecret;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.appSecret forKey:SHARED_PREFERENCE_APP_SECRET];
    [defaults synchronize];
}

-(void)setAppKeySecretBase64:(NSString*) appKeySecretBase64 {
    self.appKeySecretBase64 = appKeySecretBase64;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.appKeySecretBase64 forKey:SHARED_PREFERENCE_APP_KEY_SECRET_BASE64];
    [defaults synchronize];
}

-(void)setAuthorizationType:(NSInteger) authorizationType {
    self.authorizationType = authorizationType;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.authorizationType  forKey:SHARED_PREFERENCE_AUTHORIZATION_TYPE];
    [defaults synchronize];
}

-(void)setExpiresAt:(long) expiresAt {
    self.expiresAt = expiresAt;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithLong:self.expiresAt] forKey:SHARED_PREFERENCE_EXPIRES_AT];
    [defaults synchronize];
}

-(void)setDebugMode:(BOOL) debugMode{
    self.debugMode = debugMode;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.debugMode forKey:SHARED_PREFERENCE_DEBUG_MODE];
    [defaults synchronize];
}

-(void)setAppKeySecretBase64{
    NSString * textToEncode = [NSString stringWithFormat:@"%@:%@",self.appKey, self.appSecret];
    NSData *data = [textToEncode dataUsingEncoding:NSUTF8StringEncoding];
    self.appKeySecretBase64 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"Spark Config BASE64 : %@", self.appKeySecretBase64);
}

-(void)setBaseURLType:(NSInteger)baseURLType{
    self.baseURLType = baseURLType;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.baseURLType  forKey:SHARED_PREFERENCE_BASE_URL];
    [defaults synchronize];
}

-(void)setAppKeySecret:(NSString*)appKey appSecret:(NSString*)appSecret envType:(NSInteger) envType{
    NSLog(@"Spark Config : %@:%@ ", self.appKey, self.appSecret);
    
    [self setAppKey:appKey];
    [self setAppSecret:appSecret];
    [self setAppKeySecretBase64];
    [self setBaseURLType:envType];
}

@end
