//
//  SubmitWeightViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 2/18/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "SubmitWeightViewController.h"
#import "cCompetitionManager.h"
#import "cUserSingleton.h"

@interface SubmitWeightViewController ()

@end

@implementation SubmitWeightViewController

- (IBAction)submitWeight:(id)sender
{
    
    if (self.previewImageView.image)
    {
        cCompetitionManager *mgr = [[cCompetitionManager alloc]init];
        mgr.delegate = self;
        [mgr submitWeightWithPhoto:self.previewImageView.image];
    }
    
}

- (void)submitWeightSuccess:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:@"Score Submitted"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}

- (void)submitWeightFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}

- (IBAction)pickPhotoFromAlbum:(id)sender
{
}

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.previewImageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        UIImage * myImage = [UIImage imageNamed: @"images.jpg"];
        self.previewImageView.image = myImage;
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
