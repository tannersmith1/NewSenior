//
//  cUser.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cParty.h"

@interface cUserSingleton : NSObject {
    
    
}

+ (cUserSingleton *)getInstance;
@property (nonatomic, strong)NSMutableArray *parties;
@property (nonatomic, strong)NSString *username;
@property (nonatomic, strong)cParty *activeParty;

@end
