//
//  SecondViewController.m
//  Spark-sdk-demo
//
//  Created by Tomer Har Yoffi on 6/25/15.
//  Copyright (c) 2015 Tomer Har Yoffi. All rights reserved.
//

#import "SecondViewController.h"
#import "FileRequest.h"
#import "SparkDrive.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectFile:(id)sender{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(IBAction)uploadFile:(id)sender{
    FileRequest * fileRquest = [[FileRequest alloc] initWithFileRequest:NO publicEnable:NO path:nil fileData:_fileData];
    [[SparkDrive sharedInstance] sparkUploadFile:fileRquest succesBlock:^(FileResponse *responseObject) {
        if ([responseObject.files count] > 0) {
            [self.resultTextView setText:[[responseObject.files objectAtIndex:0] toString]];
        }else{
            [self.resultTextView setText:[responseObject toString]];
        }
    } failure:^(NSString *error) {
        [self.resultTextView setText:error];
    }];
}


// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    _selecteImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    _fileData = UIImageJPEGRepresentation(_selecteImage, 1.0);
    //Or you can get the image url from AssetsLibrary
    _filePath = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.resultTextView setText:[NSString stringWithFormat:@"File selected : %@", _filePath]];
    }];
}
@end
