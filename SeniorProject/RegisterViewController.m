//
//  RegisterViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/14/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (IBAction)registerButtonPressed:(id)sender {
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *rePassword = self.rePasswordField.text;
    
    if ( ![username isEqualToString:@""] && ![password isEqualToString:@""] && [password isEqualToString:rePassword] )
    {
        
    
        NSString *url = @"http://localhost:8888/createAccount.php";
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *params = @{@"username": username,
                                 @"password": password};
    
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             self.resultsTextView.text = text;
             if ([text isEqualToString:@"TRUE"])
             {
                 self.resultsTextView.text = @"Your account has been created";
             }
             else
             {
                 self.resultsTextView.text = @"Username taken, please try another";
             }
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             self.resultsTextView.text = [error localizedDescription];
         }];
    }
    else
    {
        self.resultsTextView.text = @"Passwords do not match or fields are empty";
    }
}

//--------------------------------------------------
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

- (IBAction)hideKeyboard:(id)sender {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.rePasswordField resignFirstResponder];
}


@end
