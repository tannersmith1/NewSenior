//
//  RouteMapViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 3/13/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "RouteMapViewController.h"


@interface RouteMapViewController ()

@end

@implementation RouteMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.routeCoordinates = [[NSMutableArray alloc]init];
    }
    return self;
}



#pragma mark MKOverlayView Delegate
//Called when an overlay is added to the map object
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *lineView = [[MKPolylineView alloc] initWithPolyline:overlay];
        lineView.lineWidth = 15;
        lineView.strokeColor = [UIColor redColor];
        lineView.fillColor = [UIColor redColor];
        return lineView;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // unpacking an array of NSValues into memory
    CLLocation *startPoint = [self.routeCoordinates objectAtIndex:0];
    CLLocationCoordinate2D *points = malloc([self.routeCoordinates count] * sizeof(CLLocationCoordinate2D));
    for(int i = 0; i < [self.routeCoordinates count]; i++) {
        CLLocation *temp = [self.routeCoordinates objectAtIndex:i];
        points[i] = temp.coordinate;
    }
    
    MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:points count:[self.routeCoordinates count]];
    free(points);

    /*
    CLLocationCoordinate2D coord[2];
    coord[0].latitude = 43.822133;
    coord[0].longitude = -122.383307;
    coord[1].latitude = 43.422785;
    coord[1].longitude = -122.12377;
    
    MKPolyline *polyline = [[MKPolyline alloc] init];
    polyline = [MKPolyline polylineWithCoordinates:coord count:2];
    
    [self.mapView addOverlay:polyline];
     */
    [self.mapView addOverlay:myPolyline];

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(startPoint.coordinate, 100, 100);
    MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
