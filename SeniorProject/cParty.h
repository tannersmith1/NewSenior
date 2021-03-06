//
//  cParty.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cCompetition.h"

@interface cParty : NSObject

@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *leader;
@property (nonatomic, strong)NSMutableArray *members;
@property (nonatomic, strong)cCompetition *activeCompetition;

- (void)setData:(NSData *)data;

@end
