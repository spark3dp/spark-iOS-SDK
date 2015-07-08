//
//  FirstViewController.h
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/25/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

@interface FirstViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray * _apiCommnads;
    NSMutableString * _resultText;
    UIImage * _selectedFile;
    NSData * _fileData;
    NSString * _filePath;
    FileResponse * _fileResponse;
}

@property (nonatomic, weak) IBOutlet UITextField * sessionTokenTypeTextField;
@property (nonatomic, weak) IBOutlet UITextView * resultTextView;


@end

