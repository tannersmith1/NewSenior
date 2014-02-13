//
//  cPartyManager.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cParty.h"

@interface cPartyManager : NSObject 

@property (nonatomic,weak)id delegate;

- (void)createPartyWithName:(NSString *)partyName;
- (void)getMembersFromParty:(NSString *)partyName;


@end
