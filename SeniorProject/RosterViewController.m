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
        NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
        NSString *url = [NSString stringWithFormat:@"%@/removeMember.php", baseURL];

       AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       NSDictionary *params = @{@"username": self.selectedMember,
                                @"teamname": user.activeParty.name};
       [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
       {
            NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
            //MANUAL SEGUE HERE
            if ([text isEqualToString:@"FALSE"])
            {
                NSLog(@"Member does not exist");
            }
            else
            {
                NSLog(@"Member removed");
                [user.activeParty.members removeObject:self.selectedMember];
                self.teamArray = user.activeParty.members;
                [self.teamsTable reloadData];
                [self viewDidAppear:YES];
            }
         
         
        }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSLog([error localizedDescription]);
        }];
    }
    else
    {
        NSLog(@"Only party leaders cannot delete team members Or cannot delete yourself");
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    cUserSingleton *user = [cUserSingleton getInstance];
    self.teamArray = [NSArray arrayWithArray:user.activeParty.members];
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
