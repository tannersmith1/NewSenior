//
//  RosterViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/29/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "RosterViewController.h"
#import "cUserSingleton.h"
#import "AFHTTPRequestOperationManager.h"
#import "cPartyManager.h"

@interface RosterViewController ()

@end

@implementation RosterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectedMember = [[NSString alloc] init];
        
    }
    return self;
}
- (IBAction)deleteButtonPressed:(id)sender
{
    //Post to web server, if credentials exist, move to main menu page
    cUserSingleton *user = [cUserSingleton getInstance];
    if([user.username isEqualToString:user.activeParty.leader] && ![user.username isEqualToString:[self.selectedMember lowercaseString]])
    {
        cPartyManager *mgr = [[cPartyManager alloc] init];
        mgr.delegate = self;
        [mgr deleteMember:self.selectedMember FromTeam:user.activeParty.name];
    }
    else
    {
        NSLog(@"Only party leaders cannot delete team members Or cannot delete yourself");
    }
}

- (void)deleteMemberSuccess:(NSString *)msg
{
    cUserSingleton *user = [cUserSingleton getInstance];
    
    self.teamArray = user.activeParty.members;
    [self.teamsTable reloadData];
    [self viewDidAppear:YES];
}

- (void)deleteMemberFailed:(NSString *)msg
{
    //NSLog(msg);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    cUserSingleton *user = [cUserSingleton getInstance];
    self.teamArray = [NSArray arrayWithArray:user.activeParty.members];
    
    if ([user.username isEqualToString:user.activeParty.leader])
    {
        self.deleteMemberButton.hidden = FALSE;
    }
    else
    {
        self.deleteMemberButton.hidden = TRUE;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    cUserSingleton *user = [cUserSingleton getInstance];
    self.teamArray = [NSArray arrayWithArray:user.activeParty.members];
    [self.teamsTable reloadData];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMember = [NSString stringWithString:[self.teamArray objectAtIndex:indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teamArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleID = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleID];
    }
    
    cell.textLabel.text = [self.teamArray objectAtIndex:indexPath.row];
    return cell;
}

@end
