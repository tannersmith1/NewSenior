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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieve name at indexPath
    NSString *teamSelected = [teamArray objectAtIndex:indexPath.row];
    cUserSingleton *user = [cUserSingleton getInstance];
    user.activeParty.name = teamSelected;
    
    
    //Retrieve party data from database based on name
    //Post to web server, if credentials exist, move to main menu page
    
    NSString *url = @"http://localhost:8888/getMembers.php";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"teamname": user.activeParty.name };
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSLog(text);
         //MANUAL SEGUE HERE
         if ([text isEqualToString:@"FALSE"])
         {
             NSLog(@"Server Echoed False");
         }
         else
         {
             user.activeParty = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

             //manual segue
             [self performSegueWithIdentifier:@"teamSelectedSegue" sender:self];
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog([error localizedDescription]);
     }];
    
    
    
    
    
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
