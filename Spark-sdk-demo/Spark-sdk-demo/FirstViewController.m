//
//  FirstViewController.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/25/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "FirstViewController.h"
#import "SparkSession.h"
#import "Constants.h"
#import "SparkAuthentication.h"
#import "AccessTokenResponse.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateSessionDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)grantSparkGuestTokenPressed:(id)sender {
    
    [[SparkAuthentication sharedInstance] getGuestToken:^(AccessTokenResponse *responseObject) {
        [self.guestTokenTextField setText:responseObject.accessToken];
        [self updateSessionDetails];
    } failure:^(NSString *error) {
        [self.guestTokenTextField setText:error];
    }];
}

- (IBAction)grantSparkAccessTokenPressed:(id)sender {
    
    [[SparkAuthentication sharedInstance] getAuthorizationCode:^(AccessTokenResponse *responseObject) {
        [self.accessTokenTextField setText:responseObject.accessToken];
        [self updateSessionDetails];
    } failure:^(NSString *error) {
        [self.accessTokenTextField setText:error];
    } parentViewController:self];
}

-(void)updateSessionDetails{
    SparkSession * currentSession = [SparkSession getActiveSession];
    
    [self.accessTokenTextField setText:currentSession.accessToken];
    [self.refreshTokenTextField setText:currentSession.refreshToken];
    
    NSString *tokenType = SPARK_TOKEN_TYPE_NONE;
    if (currentSession.authorizationType == SPARK_AUTHORIZATION_TOKEN_TYPE_REGULAR)
    {
        tokenType = SPARK_TOKEN_TYPE_REGULAR;
    }
    else if (currentSession.authorizationType == SPARK_AUTHORIZATION_TOKEN_TYPE_GUEST)
    {
        tokenType = SPARK_TOKEN_TYPE_GUEST;
    }
    
    [self.sessionTokenTypeTextField setText:tokenType];
}

@end
