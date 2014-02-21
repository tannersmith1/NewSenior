//
//  cCompetitionManager.h
//  SeniorProject
//
//  Created by Tanner Smith on 2/18/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetupCompetitionViewController.h"

@interface cCompetitionManager : NSObject
@property (nonatomic,weak)id delegate;

- (void)createCompStarting:(NSDate *)startDate withFreq:(NSString *)freq andCycles:(NSNumber *)cycles andElim:(NSString *)elim;
- (void)submitWeightWithPhoto:(UIImage *)weightPhoto;
@end
