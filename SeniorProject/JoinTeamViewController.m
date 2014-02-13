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
#import "cPartyManager.h"

@interface JoinTeamViewController ()

@end

@implementation JoinTeamViewController

- (IBAction)joinButtonPressed:(id)sender
{
    
    //Pull UI DATA
    NSString *teamName = self.teamNameField.text;
    NSString *pw = self.passwordField.text;
    
    cUserSingleton *user = [cUserSingleton getInstance];
    
    
    //Check data validity
    if(![teamName isEqualToString:@""] && ![user.parties containsObject:teamName])
        //post to web server
    {
        //TODO WHIRLIGIG
        cPartyManager *mgr = [[cPartyManager alloc]init];
        mgr.delegate = self;
        [mgr joinPartyWithName:teamName AndPassword:pw];
        
    }
    else
    {
        self.resultTextView.text = @"No team selected or you already belong to that team";
    }
}

- (void)joinPartySuccess:(NSString *)msg
{
    [self.whirligig stopAnimating];
    self.resultTextView.text = msg;
}

- (void)joinPartyFailed:(NSString *)msg
{
    [self.whirligig stopAnimating];
    self.resultTextView.text = msg;
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

@end
