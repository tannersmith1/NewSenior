//
//  cPartyManager.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "cPartyManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "cUserSingleton.h"
#import "TeamViewController.h"
#import "TeamCreationViewController.h"
#import "JoinTeamViewController.h"
#import "TeamMenuViewController.h"
#import "RosterViewController.h"

@implementation cPartyManager

//Makes calls to web service
- (void)createPartyWithName:(NSString *)teamName AndPassword:(NSString *)pw AndPublic:(NSString *)publicPrivate {
    
    cUserSingleton *user = [cUserSingleton getInstance];
    
    NSString *username = user.username;
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/createTeam.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"username": username,
                             @"password": pw,
                             @"teamname": teamName,
                             @"private": publicPrivate};
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

         if ([text isEqualToString:@"TRUE"])
         {
             [user.parties addObject:teamName];
             [self.delegate createPartySuccess:@"Your Team has been created"];
         }
         else
         {
             [self.delegate createPartySuccess:@"Team name taken, please try another"];
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate createPartyFailed:[error localizedDescription]];
     }];
}

- (void)getPartyData:(NSString *)partyName
{
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/getParty.php", baseURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"teamname": partyName };
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"FALSE"])
         {
             [self.delegate getMembersFailed:@"Web Server: False"];
         }
         else
         {
             cUserSingleton *user = [cUserSingleton getInstance];
             [user.activeParty setData:responseObject];
             
             //Tell the view controller that everything succeeded
             [self.delegate getMembersSuccess];
         }
         
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate getMembersFailed:[error localizedDescription]];
     }];
}

- (void)joinPartyWithName:(NSString *)teamName AndPassword:(NSString *)pw
{
    cUserSingleton *user = [cUserSingleton getInstance];
    NSString *username = user.username;
    
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/joinTeam.php", baseURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"username": username,
                             @"password": pw,
                             @"teamname": teamName};
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         if ([text isEqualToString:@"TRUE"])
         {
             [user.parties addObject:teamName];
             [self.delegate joinPartySuccess:@"Joined the Party"];
         }
         else
         {
             [self.delegate joinPartySuccess:@"Team does not exist, or wrong password"];
         }
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate joinPartyFailed:[error localizedDescription]];
     }];
}

- (void)deleteActiveParty
{
    cUserSingleton *user = [cUserSingleton getInstance];
    
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/deleteTeam.php", baseURL];
    
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
             [self.delegate deleteSuccess:@"Team does not exist"];
         }
         else
         {
             [self.delegate deleteSuccess:@"Team deleted"];
             [user.parties removeObject:user.activeParty.name];
         }
         
         
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate deleteFailed:[error localizedDescription]];
     }];
}

- (void)deleteMember:(NSString *)memberName FromTeam:(NSString *)teamName
{
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/removeMember.php", baseURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"username": memberName,
                             @"teamname": teamName};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         //MANUAL SEGUE HERE
         if ([text isEqualToString:@"FALSE"])
         {
             [self.delegate deleteMemberFailed:@"Member does not exist"];
         }
         else
         {
             cUserSingleton *user = [cUserSingleton getInstance];
             
             [user.activeParty.members removeObject:memberName];
             [self.delegate deleteMemberSuccess:@"Member Removed"];
             
         }
         
         
     }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate deleteMemberFailed:[error localizedDescription]];
     }];
}


@end
