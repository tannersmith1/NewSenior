//
//  MileTrackerViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 3/5/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//
#import "MileTrackerViewController.h"
#import "RouteMapViewController.h"

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
    NSString *s = [NSString stringWithFormat:@"Lat:%f, Long:%f", waypoint.coordinate.latitude, waypoint.coordinate.longitude];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Coordinates"
                                                    message: s
                                                   delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
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
