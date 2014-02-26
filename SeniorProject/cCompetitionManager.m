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
#import "SubmitWeightViewController.h"
#import "UnverifiedScoreMenuViewController.h"
#import "VerifyScoreViewController.h"
#import "ScoreBoardViewController.h"

@implementation cCompetitionManager

- (NSArray *)parseScoreboardData:(NSData *)data
{
    NSMutableArray *scores = [[NSMutableArray alloc]init];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    for (NSDictionary *row in json)
    {
        NSString *startWeight = [row objectForKey:@"startweight"];
        NSString *endWeight = [row objectForKey:@"endweight"];
        double weightLost = [startWeight intValue] - [endWeight intValue];
        double weightPercent = weightLost / (double)[startWeight intValue];
        cScoreSheet *ss = [[cScoreSheet alloc]init];
        ss.username = [row objectForKey:@"username"];
        ss.scorePercent = [NSString stringWithFormat:@"%f", weightPercent];
        [scores addObject:ss];
        
    }
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"scorePercent"
                                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [scores sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

- (void)getScoreBoard:(NSString *)teamname
{
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/getScoreBoard.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"teamname": teamname};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"FALSE"])
         {
             [self.delegate getScoreBoardFailed:text];
             
             
         }
         else
         {
             //Parse the data and send it to UI
             [self.delegate getScoreBoardSuccess:[self parseScoreboardData:responseObject]];
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate getScoreSheetFailed:[error localizedDescription]];
     }];
}

- (void)verifyWeight:(NSString *)scoresheetID withValue:(NSString *)weight
{
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/verifyWeight.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"scoresheetid": scoresheetID,
                             @"weight": weight};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"TRUE"])
         {
             [self.delegate verifyWeightSuccess:text];
             
             
         }
         else
         {
             [self.delegate verifyWeightFailed:text];
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate getScoreSheetFailed:[error localizedDescription]];
     }];
}

- (void)submitWeightWithPhoto:(UIImage *)weightPhoto
{
    cUserSingleton *user = [cUserSingleton getInstance];
    //CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), NULL);
    //NSString *timeString = [NSString stringWithFormat:@"%04d-%02d-%02d %02d:%02d:%02.0f", currentDate.year, currentDate.month, currentDate.day, currentDate.hour, currentDate.minute, currentDate.second];
    
    NSDate *submissionDate = [NSDate date];

    //Calculate the start date and end date for the cycle this submission belongs to, this is used to check if a submission already exists
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    //NSDate *submissionDate = [[NSDate alloc]init];
    //submissionDate = [dateform dateFromString:timeString];
    NSString *timeString = [dateform stringFromDate:submissionDate];
    
    //Extract date components from competition start date
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags = NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:user.activeParty.activeCompetition.startDate
                                                  toDate:submissionDate options:0];
    //Seperate Values
    NSInteger months = [components month];
    NSInteger weeks = [components week];
    NSInteger days = [components day];
    
    //Calculate the dates for when the current cycle starts and ends
    NSDate *cycleStart;
    NSDate *cycleEnd;
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    if ([user.activeParty.activeCompetition.frequency isEqualToString:@"Weekly"])
    {
        [offsetComponents setWeek:weeks];
        cycleStart = [gregorian dateByAddingComponents:offsetComponents toDate:user.activeParty.activeCompetition.startDate options:0 ];
        [offsetComponents setWeek:weeks +1];
        cycleEnd = [gregorian dateByAddingComponents:offsetComponents toDate:user.activeParty.activeCompetition.startDate options:0];
        NSLog(@"\nStart Date: %@\nFrequency: %@\nCycle: %d\nCycle Start: %@\nCycle End: %@\n", [dateform stringFromDate:user.activeParty.activeCompetition.startDate], user.activeParty.activeCompetition.frequency, (int)weeks, [dateform stringFromDate:cycleStart], [dateform stringFromDate:cycleEnd] );
    }
    else if ([user.activeParty.activeCompetition.frequency isEqualToString:@"Monthly"])
    {
        [offsetComponents setMonth:months];
        cycleStart = [gregorian dateByAddingComponents:offsetComponents toDate:user.activeParty.activeCompetition.startDate options:0 ];
        [offsetComponents setMonth:months +1];
        cycleEnd = [gregorian dateByAddingComponents:offsetComponents toDate:user.activeParty.activeCompetition.startDate options:0];
        NSLog(@"\nStart Date: %@\nFrequency: %@\nCycle: %d\nCycle Start: %@\nCycle End: %@\n", [dateform stringFromDate:user.activeParty.activeCompetition.startDate], user.activeParty.activeCompetition.frequency, (int)months, [dateform stringFromDate:cycleStart], [dateform stringFromDate:cycleEnd] );
    }
    else if ([user.activeParty.activeCompetition.frequency isEqualToString:@"Daily"])
    {
        [offsetComponents setDay:days];
        cycleStart = [gregorian dateByAddingComponents:offsetComponents toDate:user.activeParty.activeCompetition.startDate options:0 ];
        [offsetComponents setDay:days +1];
        cycleEnd = [gregorian dateByAddingComponents:offsetComponents toDate:user.activeParty.activeCompetition.startDate options:0];
        NSLog(@"\nStart Date: %@\nFrequency: %@\nCycle: %d\nCycle Start: %@\nCycle End: %@\n", [dateform stringFromDate:user.activeParty.activeCompetition.startDate], user.activeParty.activeCompetition.frequency, (int)days, [dateform stringFromDate:cycleStart], [dateform stringFromDate:cycleEnd] );
    }
    
    NSString *cycleStartString = [dateform stringFromDate:cycleStart];
    NSString *cycleEndString = [dateform stringFromDate:cycleEnd];
    NSString *startDateString = [dateform stringFromDate:user.activeParty.activeCompetition.startDate];
    
    //Make post to web server
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/submitWeight.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"teamname": user.activeParty.name,
                             @"username": user.username,
                             @"datesubmitted": timeString,
                             @"cyclestart": cycleStartString,
                             @"cycleend": cycleEndString};
    NSData *imageData = UIImageJPEGRepresentation(weightPhoto, 0.5); // image size ca. 50 KB

    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    }
    success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([text isEqualToString:@"TRUE"])
        {
            [self.delegate submitWeightSuccess:@"Succuess"];
            NSLog(@"cCompetitionManager: %@", text);
        }
        else
        {
            [self.delegate submitWeightFailed:text];
        }
        
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self.delegate submitWeightFailed:@"Failed"];
        NSLog(@"SubmitWeight: Failure %@, %@", error, operation.responseString);
    }];
}


- (void)getScoreSheet:(NSString *)isVerified
{
    cUserSingleton *user = [cUserSingleton getInstance];
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/getScoreSheets.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"teamname": user.activeParty.name,
                             @"isverified": isVerified};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"FALSE"])
         {
             
             [self.delegate getScoreSheetFailed:@"Competition created Succesfully"];
         }
         else
         {
             [self.delegate getScoreSheetSuccess:responseObject];
             
         }
         
         
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self.delegate getScoreSheetFailed:[error localizedDescription]];
     }];
}

- (void)createCompStarting:(NSDate *)startDate withFreq:(NSString *)freq andCycles:(NSNumber *)cycles andElim:(NSString *)elim;
{
    cUserSingleton *user = [cUserSingleton getInstance];
    NSDate *endDate = [self determineEndDateFrom:startDate withFreq:freq andCycles:cycles];
    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString *baseURL = NSLocalizedString(@"BaseURL", nil);
    NSString *url = [NSString stringWithFormat:@"%@/createCompetition.php", baseURL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *params = @{@"teamname": user.activeParty.name,
                             @"startdate": [dateform stringFromDate:startDate],
                             @"enddate": [dateform stringFromDate:endDate],
                             @"frequency": freq,
                             @"cycles": cycles,
                             @"iselimination": elim};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *text = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         
         
         if ([text isEqualToString:@"TRUE"])
         {
             cUserSingleton *user = [cUserSingleton getInstance];
             user.activeParty.activeCompetition.startDate = startDate;
             user.activeParty.activeCompetition.endDate = endDate;
             user.activeParty.activeCompetition.frequency = freq;
             user.activeParty.activeCompetition.cycles = cycles;
             user.activeParty.activeCompetition.elimination = elim;
             
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
