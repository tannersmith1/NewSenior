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
#import "cPartyManager.h"

@interface TeamMenuViewController ()

@end

@implementation TeamMenuViewController
- (IBAction)deleteButtonPressed:(id)sender
{
    //Check that no members besides leader exists
    cUserSingleton *user = [cUserSingleton getInstance];
    if([user.activeParty.members count] == 1 && [user.activeParty.leader isEqualToString:user.username])
    {
        //TODO:UIAlertView to ask if user is sure they want to delete team
        [self.whirligig startAnimating];
        //Post delete to web server
        cPartyManager *mgr = [[cPartyManager alloc] init];
        mgr.delegate = self;
        [mgr deleteActiveParty];
    }
    else
    {
        self.resultsTextView.text = @"Please remove all members before deleting a team";
    }
    
}

- (void)deleteSuccess:(NSString *)msg
{
    [self.navigationController popViewControllerAnimated:TRUE];

    self.resultsTextView.text = msg;
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
    
}

- (void)deleteFailed:(NSString *)msg
{
    [self.whirligig stopAnimating];
    self.resultsTextView.text = msg;
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
    cUserSingleton *user = [cUserSingleton getInstance];
    self.teamNameLabel.text = [NSString stringWithFormat:@"Team name: %@",user.activeParty.name];
    
    if ([user.username isEqualToString:user.activeParty.leader])
    {
        self.deleteTeamButton.hidden = FALSE;
    }
    else
    {
        self.deleteTeamButton.hidden = TRUE;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        cUserSingleton *user = [cUserSingleton getInstance];
        [user.activeParty.activeCompetition clearData];
    }
    
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
