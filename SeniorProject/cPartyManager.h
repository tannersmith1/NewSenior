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

- (void)createPartyWithName:(NSString *)teamName AndPassword:(NSString *)pw AndPublic:(NSString *)publicPrivate;
- (void)joinPartyWithName:(NSString *)teamName AndPassword:(NSString *)pw;
//Uses data from singleton to post
- (void)deleteActiveParty;
//Saves the selected party information into the user singleton
- (void)getPartyData:(NSString *)partyName;
- (void)deleteMember:(NSString *)memberName FromTeam:(NSString *)teamName;


@end
