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
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    self.members = [NSMutableArray arrayWithArray:[json objectForKey:@"members"]];
    self.name = [NSString stringWithString:[json objectForKey:@"name"]];
    self.leader = [NSString stringWithString:[json objectForKey:@"leader"]];
    
   
}



@end
