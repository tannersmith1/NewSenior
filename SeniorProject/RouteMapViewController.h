//
//  RouteMapViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 3/13/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RouteMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong)IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *routeCoordinates;

@end
