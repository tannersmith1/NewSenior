//
//  MileTrackerViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 3/5/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//
#define kDistanceCalculationInterval 10 // the interval (seconds) at which we calculate the user's distance
#define kNumLocationHistoriesToKeep 5 // the number of locations to store in history so that we can look back at them and determine which is most accurate
#define kValidLocationHistoryDeltaInterval 3 // the maximum valid age in seconds of a location stored in the location history
#define kMinLocationsNeededToUpdateDistance 3 // the number of locations needed in history before we will even update the current distance
#define kRequiredHorizontalAccuracy 40.0f // the required accuracy in meters for a location.  anything above this number will be discarded

#import "MileTrackerViewController.h"

@interface MileTrackerViewController ()

@end

@implementation MileTrackerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    self.locationHistory = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender
{
    [self.locationManager startUpdatingLocation];
}
- (IBAction)stopButtonPressed:(id)sender
{
    [self.locationManager stopUpdatingLocation];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    

        // test the age of the location measurement to determine if the measurement is cached
        // in most cases you will not want to rely on cached measurements
        NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];

        if (locationAge > 5.0) return;
        
        // test that the horizontal accuracy does not indicate an invalid measurement
        if (newLocation.horizontalAccuracy < 0) return;
        

        if (newLocation.horizontalAccuracy <= 30)
        {
            if (self.lastBestLocation != Nil)
            {
                CLLocationDistance distance = [newLocation distanceFromLocation:self.lastBestLocation];
                self.totalDistance += distance;
                self.distance.text = [NSString stringWithFormat:@"%.2f m",self.totalDistance];
                NSString *debugText = self.debugTextView.text;
            self.debugTextView.text = [NSString stringWithFormat:@"%@\nNew:%f,%f",debugText, newLocation.coordinate.latitude, newLocation.coordinate.longitude];
            }
            else
            {
                
            }
            self.lastBestLocation = newLocation;
            
        }
    
    
}

@end
