//
//  MileTrackerViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 3/5/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSLocationManager.h"

@interface MileTrackerViewController : UIViewController <PSLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *strengthLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) NSMutableArray *routeCoordinates;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
- (IBAction)routeMapsPressed:(id)sender;

@end