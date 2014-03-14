//
//  RouteHistoryViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 3/13/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cMileManager.h"
#import <MapKit/MapKit.h>

@interface RouteHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *tableArray;
@property (nonatomic, strong)IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *routeCoordinates;

- (void)getCoordinatesSuccess:(NSData *)data;
- (void)getCoordinatesFailed:(NSString *)msg;

- (void)getRouteIdsSuccess:(NSData *)data;
- (void)getRouteIdsFailed:(NSString *)msg;

@end
