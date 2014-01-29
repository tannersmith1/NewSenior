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
    
    //Post to web server, if credentials exist, move to main menu page
    
    self.resultsTextView.text = @"Login button pressed";
    NSString *url = @"http://localhost:8888/login.php";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"username": username,
                             @"password": password};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        self.resultsTextView.text = text;
        //MANUAL SEGUE HERE
        if ([text isEqualToString:@"FALSE"])
        {
            self.resultsTextView.text = @"Username and password are incorrect";
        }
        else
        {
            cUserSingleton *user = [cUserSingleton getInstance];
            NSArray *parties = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            user.parties = [[NSMutableArray alloc] initWithArray:parties];
            user.username = [[NSString alloc] initWithString:username];
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
        

    }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        self.resultsTextView.text = [error localizedDescription];
    }];
    
     
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
