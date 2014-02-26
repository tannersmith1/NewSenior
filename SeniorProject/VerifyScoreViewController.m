//
//  VerifyScoreViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 2/25/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "VerifyScoreViewController.h"
#import "AFHTTPRequestOperationManager.h"
@interface VerifyScoreViewController ()

@end

@implementation VerifyScoreViewController
- (IBAction)verifyButtonPressed:(id)sender {
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
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/upload/%@.jpg", baseURL, self.sheet.scoreID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];

    [manager GET:url parameters:nil
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        self.previewImageField.image = responseObject;
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
         
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
