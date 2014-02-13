//
//  cPlayerManager.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/23/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "cPlayerManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "cUserSingleton.h"


@implementation cPlayerManager

- (void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password
{
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/login.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"username": username,
                             @"password": password};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"FALSE"])
         {
             [self.delegate loginFailed:@"Username and password are incorrect"];
         }
         else
         {
             cUserSingleton *user = [cUserSingleton getInstance];
             NSArray *parties = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
             user.parties = [[NSMutableArray alloc] initWithArray:parties];
             user.username = [[NSString alloc] initWithString:username];
             [self.delegate loginSuccess];
             
         }
         
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate loginFailed:[error localizedDescription]];
     }];
}

- (void)registerWithUsername:(NSString *)username AndPassword:(NSString *)password
{
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/createAccount.php", baseURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"username": username,
                             @"password": password};
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         [self.delegate registerSuccess:text];
         
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate registerFailed:[error localizedDescription]];
     }];
}

@end
