//
//  MileTrackerViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 3/5/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MileTrackerViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)NSMutableArray *locationHistory;
@property (nonatomic, strong)NSDate *startTimestamp;
@property (nonatomic)NSTimeInterval lastDistanceCalculation;
@property (nonatomic,strong)CLLocation *bestEffortAtLocation;
@property (nonatomic, strong)CLLocation *lastBestLocation;
@property (nonatomic)CLLocationDistance totalDistance;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UITextView *debugTextView;

@end
