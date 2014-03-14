//
//  cRoute.h
//  SeniorProject
//
//  Created by Tanner Smith on 3/13/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cRoute : NSObject

@property (nonatomic, strong)NSString *routeID;
@property (nonatomic,strong)NSString *metersTravelled;
@property (nonatomic, strong)NSDate *dateSubmitted;
//Array of CLLocations
@property (nonatomic, strong)NSMutableArray *coordinates;

@end
