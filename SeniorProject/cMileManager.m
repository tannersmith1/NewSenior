//
//  cMileManager.m
//  SeniorProject
//
//  Created by Tanner Smith on 3/13/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "cMileManager.h"
#import "cUserSingleton.h"
#import "AFHTTPRequestOperationManager.h"
#import "RouteHistoryViewController.h"
#import "MileTrackerViewController.h"

@implementation cMileManager

- (void)getCoordinatesForRouteId:(NSString *)routeId
{

    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/getCoordinates.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"routeid": routeId};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"FALSE"])
         {
             
             [self.delegate getCoordinatesFailed:@"Failed"];
         }
         else
         {
             [self.delegate getCoordinatesSuccess:responseObject];
             
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate getCoordinatesFailed:[error localizedDescription]];
     }];
}

- (void)getRouteIds
{
    cUserSingleton *user = [cUserSingleton getInstance];
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/getRoutes.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"username": user.username};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"FALSE"])
         {
             
             [self.delegate getRouteIdsFailed:@"Failed"];
         }
         else
         {
             [self.delegate getRouteIdsSuccess:responseObject];
             
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate getRouteIdsFailed:[error localizedDescription]];
     }];
}

- (void)saveRoute:(NSString *)jsonRoute
{
    cUserSingleton *user = [cUserSingleton getInstance];
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/saveRoute.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"route": jsonRoute,
                             @"username": user.username};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"TRUE"])
         {
             
             [self.delegate saveRouteSuccess:text];
         }
         else
         {
             [self.delegate saveRouteFailed:text];
             
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate saveRouteFailed:[error localizedDescription]];
     }];
}

@end
