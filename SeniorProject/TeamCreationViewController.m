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

@interface TeamCreationViewController ()

@end

@implementation TeamCreationViewController


- (IBAction)createButtonPressed:(id)sender {
    
    
    //Gather UI field data
    NSString *teamName = self.nameField.text;
    NSString *pw = self.pwField.text;
    NSString *publicPrivate = [self.privateSwitcher titleForSegmentAtIndex:self.privateSwitcher.selectedSegmentIndex];
    
    if(![teamName isEqualToString:@""])
    //post to web server
    {
        cUserSingleton *user = [cUserSingleton getInstance];
        
        NSString *username = user.username;
        NSString *url = @"http://localhost:8888/createTeam.php";
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *params = @{@"username": username,
                                 @"password": pw,
                                 @"teamname": teamName,
                                 @"private": publicPrivate};
        
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             self.resultsTextView.text = text;
             if ([text isEqualToString:@"TRUE"])
             {
                 self.resultsTextView.text = @"Your Team has been created";
                 [user.parties addObject:teamName];
             }
             else
             {
                 self.resultsTextView.text = @"Team name taken, please try another";
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             self.resultsTextView.text = [error localizedDescription];
         }];
    }
    else
    {
        self.resultsTextView.text = @"Please input a name";
    }
    
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
