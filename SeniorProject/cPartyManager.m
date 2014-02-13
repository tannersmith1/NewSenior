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

@implementation cPartyManager

//Makes calls to web service
- (void)createPartyWithName:(NSString *)partyName {
    //Check that the party name is available

    //If the name is available submit it for creation
    
    //Testing
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                      message:partyName
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (void)getMembersFromParty:(NSString *)partyName
{
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/getMembers.php", baseURL];
    
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



@end
