//
//  JoinTeamViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/24/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "JoinTeamViewController.h"
#import "cUserSingleton.h"
#import "AFHTTPRequestOperationManager.h"

@interface JoinTeamViewController ()

@end

@implementation JoinTeamViewController

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
    [self.teamNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (IBAction)joinButtonPressed:(id)sender
{

    //Pull UI DATA
    NSString *teamName = self.teamNameField.text;
    NSString *pw = self.passwordField.text;

    cUserSingleton *user = [cUserSingleton getInstance];
    NSString *username = user.username;
    
    //Check data validity
    if(![teamName isEqualToString:@""] && ![user.parties containsObject:teamName])
    //post to web server
    {
        
        
        NSString *url = @"http://localhost:8888/joinTeam.php";
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *params = @{@"username": username,
                                 @"password": pw,
                                 @"teamname": teamName};
        
         [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             self.resultTextView.text = text;
             if ([text isEqualToString:@"TRUE"])
             {
                 [user.parties addObject:teamName];
             }
             else
             {
                 self.resultTextView.text = @"Team does not exist, or wrong password";
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             self.resultTextView.text = [error localizedDescription];
         }];
    }
    else
    {
        self.resultTextView.text = @"No team selected or you already belong to that team";
    }}
@end
