//
//  MileTrackerViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 3/5/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//
#import "MileTrackerViewController.h"
#import "RouteMapViewController.h"
#import "cMileManager.h"

@interface MileTrackerViewController ()

@end

@implementation MileTrackerViewController

@synthesize strengthLabel = _strengthLabel;
@synthesize distanceLabel = _distanceLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [PSLocationManager sharedLocationManager].delegate = self;
    self.routeCoordinates = [[NSMutableArray alloc]init];
    
}

- (void)saveRouteSuccess:(NSString *)msg;
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}

- (void)saveRouteFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Save Route Failure"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}

- (void)saveRoutePressed:(id)sender
{
    if ([self.routeCoordinates count] > 1 && ![self.distanceLabel.text isEqualToString:@""])
    {
        //POST route to web server
        cMileManager *mgr = [[cMileManager alloc] init];
        mgr.delegate = self;
        cRoute *route = [[cRoute alloc] init];
        route.metersTravelled = self.distanceLabel.text;
        route.coordinates = self.routeCoordinates;
        route.dateSubmitted = [NSDate date];
        //[mgr saveRoute:route];
        
        NSDateFormatter *fo = [[NSDateFormatter alloc] init];
        [fo setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [fo stringFromDate:route.dateSubmitted];
        NSMutableArray *latStringArray = [[NSMutableArray alloc] init];
        NSMutableArray *longStringArray = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < [route.coordinates count]; i++)
        {
            CLLocation *loc = [route.coordinates objectAtIndex:i];
            NSString *latString = [NSString stringWithFormat:@"%f",loc.coordinate.latitude];
            NSString *longString = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
            [latStringArray addObject:latString];
            [longStringArray addObject:longString];
        }
        
        NSArray *keys = [NSArray arrayWithObjects:@"meterstravelled", @"datesubmitted", @"latitudes", @"longitudes",  nil];
        NSArray *object = [NSArray arrayWithObjects:route.metersTravelled, dateString, latStringArray, longStringArray, nil];
        NSDictionary *routeData = [[NSDictionary alloc]initWithObjects:object forKeys:keys];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:routeData options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [mgr saveRoute:jsonString];
    }
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RouteMapViewController *dest = (RouteMapViewController *)[segue destinationViewController];
    
    dest.routeCoordinates = self.routeCoordinates;
}



- (IBAction)routeMapsPressed:(id)sender
{
    //Manual segue to new view
    //if ([self.routeCoordinates count] > 1)
    {
        [self performSegueWithIdentifier:@"routeMapSegue" sender:self];
    }
    
}

- (IBAction)startButtonPressed:(id)sender
{
    [[PSLocationManager sharedLocationManager] prepLocationUpdates];
    [[PSLocationManager sharedLocationManager] startLocationUpdates];
}

- (IBAction)stopButtonPressed:(id)sender
{
    [[PSLocationManager sharedLocationManager] stopLocationUpdates];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark PSLocationManagerDelegate

- (void)locationManager:(PSLocationManager *)locationManager waypoint:(CLLocation *)waypoint calculatedSpeed:(double)calculatedSpeed
{
   
    [self.routeCoordinates addObject:waypoint];
    
}

- (void)locationManager:(PSLocationManager *)locationManager signalStrengthChanged:(PSLocationManagerGPSSignalStrength)signalStrength {
    NSString *strengthText;
    if (signalStrength == PSLocationManagerGPSSignalStrengthWeak) {
        strengthText = NSLocalizedString(@"Weak", @"");
    } else if (signalStrength == PSLocationManagerGPSSignalStrengthStrong) {
        strengthText = NSLocalizedString(@"Strong", @"");
    } else {
        strengthText = NSLocalizedString(@"...", @"");
    }
    
    self.strengthLabel.text = strengthText;
}

- (void)locationManagerSignalConsistentlyWeak:(PSLocationManager *)locationManager {
    self.strengthLabel.text = NSLocalizedString(@"Consistently Weak", @"");
}

- (void)locationManager:(PSLocationManager *)locationManager distanceUpdated:(CLLocationDistance)distance {
    self.distanceLabel.text = [NSString stringWithFormat:@"%.2f %@", distance, NSLocalizedString(@"meters", @"")];
}

- (void)locationManager:(PSLocationManager *)locationManager error:(NSError *)error {
    // location services is probably not enabled for the app
    self.strengthLabel.text = NSLocalizedString(@"Unable to determine location", @"");
}

@end
