//
//  TeamMenuViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/28/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "TeamMenuViewController.h"
#import "cUserSingleton.h"
#import "AFHTTPRequestOperationManager.h"

@interface TeamMenuViewController ()

@end

@implementation TeamMenuViewController
- (IBAction)deleteButtonPressed:(id)sender
{
    //Check that no members besides leader exists
    cUserSingleton *user = [cUserSingleton getInstance];
    if([user.activeParty.members count] == 1 && [user.activeParty.leader isEqualToString:user.username])
    {
        //Post delete to web server
        //Post to web server, if credentials exist, move to main menu page
        
        NSString *url = @"http://localhost:8888/deleteTeam.php";
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *params = @{@"username": user.username,
                                 @"teamname": user.activeParty.name};
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             
             //MANUAL SEGUE HERE
             if ([text isEqualToString:@"FALSE"])
             {
                 self.resultsTextView.text = @"Team does not exist";
             }
             else
             {
                 self.resultsTextView.text = @"Team deleted";
                 [user.parties removeObject:user.activeParty.name];
             }
             
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             self.resultsTextView.text = [error localizedDescription];
         }];
    }
    else
    {
        self.resultsTextView.text = @"Please remove all members before deleting a team";
    }
    
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
    cUserSingleton *user = [cUserSingleton getInstance];
    self.teamNameLabel.text = [NSString stringWithFormat:@"Team name: %@",user.activeParty.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
