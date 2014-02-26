//
//  VerifyWeightsViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 2/25/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "UnverifiedScoreMenuViewController.h"
#import "cCompetitionManager.h"
#import "cScoreSheet.h"
#import "VerifyScoreViewController.h"

@interface UnverifiedScoreMenuViewController ()

@end

@implementation UnverifiedScoreMenuViewController

- (void)viewWillAppear:(BOOL)animated
{
    cCompetitionManager *mgr = [[cCompetitionManager alloc] init];
    mgr.delegate = self;
    [mgr getScoreSheet:@"0"];
}

- (void)getScoreSheetSuccess:(NSData *)data
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(text);

    NSArray *ids = [NSArray arrayWithArray:[json objectForKey:@"scoresheetid"]];
    NSArray *usernames = [NSArray arrayWithArray:[json objectForKey:@"username"]];
    NSMutableArray *scoreSheets = [[NSMutableArray alloc] init];
    
    for (int c = 0; c < [ids count]; c++)
    {
        cScoreSheet *newSheet = [[cScoreSheet alloc]init];
        newSheet.scoreID = [ids objectAtIndex:c];
        newSheet.username = [usernames objectAtIndex:c];
        [scoreSheets addObject:newSheet];
    }
    self.scoreArray = [NSArray arrayWithArray:scoreSheets];
    [self.scoreTable reloadData];
}
- (void)getScoreSheetFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                          message:@"Could not get any score sheets"
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

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    NSIndexPath *indexPath = [self.scoreTable indexPathForCell:sender];
    //Get the selected object in order to fill out the detail view

        
    VerifyScoreViewController *dest = [segue destinationViewController];
    dest.sheet = [self.scoreArray objectAtIndex:indexPath.row];

        
    //NSLog(@"The title is: %@, and the info is: %@.",dest.locTitle,dest.locInfo);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Manual segue to screen with photo and weight input fields
    [self performSegueWithIdentifier:@"verifyScoreSheetSegue" sender:self];
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
    cScoreSheet *sheet = [self.scoreArray objectAtIndex:indexPath.row];
    cell.textLabel.text = sheet.username;;
    return cell;
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

@end
