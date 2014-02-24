//
//  cParty.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "cParty.h"

@implementation cParty

- (void)setData:(NSData *)data
{
    NSError *e = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&e];

    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(text);

    self.members = [NSMutableArray arrayWithArray:[json objectForKey:@"members"]];
    self.name = [NSString stringWithString:[json objectForKey:@"name"]];
    self.leader = [NSString stringWithString:[json objectForKey:@"leader"]];
    
    NSDictionary *competition = [NSDictionary dictionaryWithDictionary:[json objectForKey:@"competition"]];

    if (![[competition objectForKey:@"cycles"] isKindOfClass:[NSNull class]])
    {
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.activeCompetition.startDate = [dateformatter dateFromString:[competition objectForKey:@"startdate"]];
        self.activeCompetition.endDate = [dateformatter dateFromString:[competition objectForKey:@"enddate"]];
        self.activeCompetition.frequency = [NSString stringWithString:[competition objectForKey:@"frequency"]];
        self.activeCompetition.cycles = [NSNumber numberWithInt:[[competition objectForKey:@"cycles"] intValue]];
        self.activeCompetition.elimination = [NSString stringWithString:[competition objectForKey:@"iselimination"]];
        if ([[competition objectForKey:@"iselimination"]intValue] == 1)
        {
            self.activeCompetition.elimination = @"elimination";
        }
        else
        {
            self.activeCompetition.elimination = @"non-elimination";
        }
        
    }
    
}



@end
