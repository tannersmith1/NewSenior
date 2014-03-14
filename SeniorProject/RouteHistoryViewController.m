//
//  RouteHistoryViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 3/13/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "RouteHistoryViewController.h"
#import "RouteMapViewController.h"

@interface RouteHistoryViewController ()

@end

@implementation RouteHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RouteMapViewController *dest = (RouteMapViewController *)[segue destinationViewController];
    
    dest.routeCoordinates = self.routeCoordinates;
}

- (void)getCoordinatesSuccess:(NSData *)data
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(text);
    
    
    NSArray *latitudes = [json objectForKey:@"latitudes"];
    NSArray *longitudes = [json objectForKey:@"longitudes"];
    NSMutableArray *points = [[NSMutableArray alloc]init];
    
    for (int c = 0; c < [latitudes count]; c++)
    {
        NSString *lat = [latitudes objectAtIndex:c];
        NSString *longit = [longitudes objectAtIndex:c];
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[longit doubleValue]];
        
        [points addObject:loc];
    }

    
    //Send coordinates to RouteMapViewController for display
    self.routeCoordinates = points;
    [self performSegueWithIdentifier:@"routeMapSegue" sender:self];
}

- (void)getCoordinatesFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Post to web server
    cMileManager *mgr = [[cMileManager alloc] init];
    mgr.delegate = self;
    cRoute *route = [[cRoute alloc]init];
    route = [self.tableArray objectAtIndex:indexPath.row];
    [mgr getCoordinatesForRouteId:route.routeID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleID = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Route: %d", indexPath.row];
    return cell;
}

- (void)getRouteIdsSuccess:(NSData *)data
{
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(text);
    
    
    NSMutableArray *routes = [[NSMutableArray alloc] init];
    
    for (int c = 0; c < [json count]; c++)
    {
        cRoute *temp = [[cRoute alloc]init];
        temp.routeID = [json objectAtIndex:c];
        [routes addObject:temp];
    }
    self.tableArray = [NSArray arrayWithArray:routes];
    [self.tableView reloadData];
}

- (void)getRouteIdsFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //GET routes for user from web server
    cMileManager *mgr = [[cMileManager alloc] init];
    mgr.delegate = self;
    [mgr getRouteIds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
