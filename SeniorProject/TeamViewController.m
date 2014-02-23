//
//  TeamViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/23/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "TeamViewController.h"
#import "cUserSingleton.h"
#import "AFHTTPRequestOperationManager.h"
#import "cPartyManager.h"

@interface TeamViewController ()

@end

@implementation TeamViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    cUserSingleton *user = [cUserSingleton getInstance];
    teamArray = [NSArray arrayWithArray:user.parties];
}

- (void)viewDidAppear:(BOOL)animated
{
    cUserSingleton *user = [cUserSingleton getInstance];
    teamArray = [NSArray arrayWithArray:user.parties];
    [self.teamsTable reloadData];
}


- (void)getMembersSuccess
{
    [self performSegueWithIdentifier:@"teamSelectedSegue" sender:self];
}

- (void)getMembersFailed:(NSString *)msg
{
    //No results window on this page
    NSLog(@"Get Members Failed: %@", msg);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieve name at indexPath
    NSString *selectedParty = [teamArray objectAtIndex:indexPath.row];
    cUserSingleton *user = [cUserSingleton getInstance];
    user.activeParty.name = selectedParty;
    
    
    //Retrieve party data from database based on name
    //Post to web server, if credentials exist, move to main menu page
    cPartyManager *mgr = [[cPartyManager alloc] init];
    mgr.delegate = self;
    [mgr getPartyData:selectedParty];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [teamArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleID = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleID];
    }
    
    cell.textLabel.text = [teamArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
