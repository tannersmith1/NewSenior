//
//  LoginViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/14/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MainMenuViewController.h"
#import "cUserSingleton.h"
#import "cPlayerManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(IBAction)pressedLoginButton:(id)sender {
    
    //Retrieve data from UI
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    if ( ![username isEqualToString:@""] && ![password isEqualToString:@""] )
    {
        //Post to web server, if credentials exist, move to main menu page
        [self.whirligig startAnimating];
    
        cPlayerManager *mgr = [[cPlayerManager alloc] init];
        mgr.delegate = self;
        [mgr loginWithUsername:username AndPassword:password];
    }
    else
    {
        self.resultsTextView.text = @"Please enter a username and password";
    }
    
}

- (void)loginSuccess
{
    [self.whirligig stopAnimating];
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}

- (void)loginFailed:(NSString *)msg
{
    [self.whirligig stopAnimating];
    self.resultsTextView.text = msg;
}

//-----------------------------------------------------------------------
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

- (void)viewDidAppear:(BOOL)animated
{
    self.resultsTextView.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hideKeyboard:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
