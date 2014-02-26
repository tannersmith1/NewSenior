//
//  ScoreBoardViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 2/25/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "ScoreBoardViewController.h"
#import "cScoreSheet.h"
#import "cCompetitionManager.h"
#import "cUserSingleton.h"

@interface ScoreBoardViewController ()

@end

@implementation ScoreBoardViewController

- (void)getScoreBoardSuccess:(NSArray *)scores
{
    self.scoreArray = [NSMutableArray arrayWithArray:scores];
    [self.tableView reloadData];
}

- (void)getScoreBoardFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieve name at indexPath
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scoreArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleID = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleID];
    }
    
    cScoreSheet *ss = [self.scoreArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@", ss.username, ss.scorePercent];
    return cell;
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
    
    //Get scores from server
    cUserSingleton *user = [cUserSingleton getInstance];
    cCompetitionManager *mgr = [[cCompetitionManager alloc] init];
    mgr.delegate = self;
    [mgr getScoreBoard:user.activeParty.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
