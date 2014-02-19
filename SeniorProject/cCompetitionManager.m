//
//  cCompetitionManager.m
//  SeniorProject
//
//  Created by Tanner Smith on 2/18/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "cCompetitionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "cUserSingleton.h"

@implementation cCompetitionManager


- (void)createCompStarting:(NSDate *)startDate withFreq:(NSString *)freq andCycles:(NSNumber *)cycles andElim:(NSString *)elim;
{
    cUserSingleton *user = [cUserSingleton getInstance];
    NSDate *endDate = [self determineEndDateFrom:startDate withFreq:freq andCycles:cycles];
    
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/createCompetition.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"teamname": user.activeParty.name,
                             @"startdate": startDate,
                             @"enddate": endDate,
                             @"frequency": freq,
                             @"cycles": cycles,
                             @"iselimination": elim};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"TRUE"])
         {
             NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSArray *parties = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
             //TODO: SAVE DATA INTO USERSINGLETON
             NSLog(text);
             [self.delegate setupCompetitionSuccess:@"Competition created Succesfully"];
         }
         else
         {
             [self.delegate setupCompetitionFailed:@"Team already has a competition"];
             
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate setupCompetitionFailed:[error localizedDescription]];
     }];
}

- (NSDate *)determineEndDateFrom:(NSDate *)startDate withFreq:(NSString *)freq andCycles:(NSNumber *)cycles
{
    NSDateComponents *dateComponent = [[NSDateComponents alloc]init];
    
    if ([freq isEqualToString:@"Weekly"])
    {
        dateComponent.week = [cycles integerValue];
    }
    else if ([freq isEqualToString:@"Monthly"])
    {
        dateComponent.month = [cycles integerValue];
    }
    else
    {
        //Debug clause, currently 30s
        dateComponent.second = 30*[cycles integerValue];
    }
    
    NSCalendar *theCalender = [NSCalendar currentCalendar];
    NSDate *endDate = [theCalender dateByAddingComponents:dateComponent toDate:startDate options:0];
    
    NSString *text = [NSString stringWithFormat:@"End Date:%@",[endDate description]];
    NSLog(text);
    return endDate;
}

@end
