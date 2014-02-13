//
//  TeamCreationViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "TeamCreationViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "cUserSingleton.h"
#import "cPartyManager.h"

@interface TeamCreationViewController ()

@end

@implementation TeamCreationViewController


- (IBAction)createButtonPressed:(id)sender {
    
    
    //Gather UI field data
    NSString *teamName = self.nameField.text;
    NSString *pw = self.pwField.text;
    NSString *publicPrivate = [self.privateSwitcher titleForSegmentAtIndex:self.privateSwitcher.selectedSegmentIndex];
    
    if(![teamName isEqualToString:@""])
    //Post to web server
    {
        [self.whirligig startAnimating];
        
        cPartyManager *mgr = [[cPartyManager alloc] init];
        mgr.delegate = self;
        [mgr createPartyWithName:teamName AndPassword:pw AndPublic:publicPrivate];
    }
    else
    {
        self.resultsTextView.text = @"Please input a name";
    }
    
}

- (void)createPartySuccess:(NSString *)msg
{
    [self.whirligig stopAnimating];
    self.resultsTextView.text = msg;
}

- (void)createPartyFailed:(NSString *)msg
{
    [self.whirligig stopAnimating];
    self.resultsTextView.text = msg;
}

//-------------------------------------------------------------------

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.nameField resignFirstResponder];
    [self.pwField resignFirstResponder];
}

   


@end
