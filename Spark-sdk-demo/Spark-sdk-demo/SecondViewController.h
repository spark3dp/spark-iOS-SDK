//
//  SecondViewController.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/25/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImage * _selecteImage;
    NSString * _filePath;
}

-(IBAction)selectFile:(id)sender;
-(IBAction)uploadFile:(id)sender;
@end

