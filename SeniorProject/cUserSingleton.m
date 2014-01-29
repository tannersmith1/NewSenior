//
//  cUser.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "cUserSingleton.h"

@implementation cUserSingleton
@synthesize parties;

static cUserSingleton *sharedObject = nil;

+ (cUserSingleton *)getInstance
{
    @synchronized(self)
    {
        if(!sharedObject)
        {
            sharedObject = [[cUserSingleton alloc] init];
            sharedObject.activeParty = [[cParty alloc] init];
        }
    }
    
    return sharedObject;
}




@end
