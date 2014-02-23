//
//  cCompetition.h
//  SeniorProject
//
//  Created by Tanner Smith on 2/18/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cCompetition : NSObject

@property (nonatomic, strong)NSDate *startDate;
@property (nonatomic, strong)NSDate *endDate;
@property (nonatomic, strong)NSString *frequency;
@property (nonatomic, strong)NSNumber *cycles;
@property (nonatomic, strong)NSString *elimination;

- (void)clearData;

@end
