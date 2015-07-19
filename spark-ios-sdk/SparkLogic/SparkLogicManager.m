//
//  SparkLogicManager.m
//  spark-ios-sdk
//
//  Created by Autodesk on 6/14/15.
//  Copyright (c) 2015 Autodesk. All rights reserved.
//

#import "SparkLogicManager.h"
#import "Constants.h"
#import "NSData+MPBase64.h"

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
    _accessToken = accessToken;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_accessToken forKey:SHARED_PREFERENCE_ACCESS_TOKEN];
    [defaults synchronize];
}

-(void)setRefreshToken:(NSString*) refreshToken {
    _refreshToken = refreshToken;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_refreshToken forKey:SHARED_PREFERENCE_REFRESH_TOKEN];
    [defaults synchronize];
}

-(void)setAppKey:(NSString*) appKey {
    _appKey = appKey;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_appKey forKey:SHARED_PREFERENCE_APP_KEY];
    [defaults synchronize];
}

-(void)setAppSecret:(NSString*) appSecret {
    _appSecret = appSecret;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_appSecret forKey:SHARED_PREFERENCE_APP_SECRET];
    [defaults synchronize];
}

-(void)setAppKeySecretBase64:(NSString*) appKeySecretBase64 {
    _appKeySecretBase64 = appKeySecretBase64;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_appKeySecretBase64 forKey:SHARED_PREFERENCE_APP_KEY_SECRET_BASE64];
    [defaults synchronize];
}

-(void)setAuthorizationType:(NSInteger) authorizationType {
    _authorizationType = authorizationType;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:_authorizationType  forKey:SHARED_PREFERENCE_AUTHORIZATION_TYPE];
    [defaults synchronize];
}

-(void)setExpiresAt:(long) expiresAt {
    _expiresAt = expiresAt;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithLong:_expiresAt] forKey:SHARED_PREFERENCE_EXPIRES_AT];
    [defaults synchronize];
}

-(void)setDebugMode:(BOOL) debugMode{
    _debugMode = debugMode;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:_debugMode forKey:SHARED_PREFERENCE_DEBUG_MODE];
    [defaults synchronize];
}

-(void)setAppKeySecretBase64{
    NSString * textToEncode = [NSString stringWithFormat:@"%@:%@",self.appKey, self.appSecret];
    NSData *data = [textToEncode dataUsingEncoding:NSUTF8StringEncoding];
    _appKeySecretBase64 = [data mp_base64EncodedString];
    
    NSLog(@"Spark Config BASE64 : %@", self.appKeySecretBase64);
}

-(void)setBaseURLType:(NSInteger)baseURLType{
    _baseURLType = baseURLType;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:_baseURLType  forKey:SHARED_PREFERENCE_BASE_URL];
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
