//
//  cMileManager.h
//  SeniorProject
//
//  Created by Tanner Smith on 3/13/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cRoute.h"

@interface cMileManager : NSObject

@property (nonatomic,weak)id delegate;

- (void)saveRoute:(NSString *)jsonRoute;
- (void)getRouteIds;
- (void)getCoordinatesForRouteId:(NSString *)routeId;

@end
