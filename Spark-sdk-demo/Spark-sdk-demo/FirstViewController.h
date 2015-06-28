//
//  FirstViewController.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/25/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface FirstViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField * accessTokenTextField;
@property (nonatomic, weak) IBOutlet UITextField * refreshTokenTextField;
@property (nonatomic, weak) IBOutlet UITextField * sessionTokenTypeTextField;
@property (nonatomic, weak) IBOutlet UITextField * guestTokenTextField;

- (IBAction)grantSparkGuestTokenPressed:(id)sender;
- (IBAction)grantSparkAccessTokenPressed:(id)sender;

@end

