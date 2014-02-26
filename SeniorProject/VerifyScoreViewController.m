//
//  VerifyScoreViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 2/25/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "VerifyScoreViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "cCompetitionManager.h"
@interface VerifyScoreViewController ()

@end

@implementation VerifyScoreViewController

- (IBAction)hideKeyboard:(id)sender
{
    [self.weightField resignFirstResponder];
}

- (IBAction)verifyButtonPressed:(id)sender
{
    if (![self.weightField.text isEqualToString:@""])
    {
        //Make post to verify score
        cCompetitionManager *mgr = [[cCompetitionManager alloc] init];
        mgr.delegate = self;
        [mgr verifyWeight:self.sheet.scoreID withValue:self.weightField.text];
    }
}

- (void)verifyWeightSuccess:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)verifyWeightFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
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
    
    //Retrieve image for score sheet verification
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *urlString = [NSString stringWithFormat:@"%@/upload/%@.jpg", baseURL, self.sheet.scoreID];


    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: urlString]];
    self.previewImageField.image = [UIImage imageWithData: imageData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
