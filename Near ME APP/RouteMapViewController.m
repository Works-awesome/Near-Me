//
//  RouteMapViewController.m
//  Near ME APP
//
//  Created by Arjun Hanswal on 10/10/16.
//  Copyright © 2016 Com.BLE  TestApp. All rights reserved.
//

#import "RouteMapViewController.h"

#define kDirectionsURL @"http://maps.googleapis.com/maps/api/directions/json?"
@interface RouteMapViewController ()

@end

@implementation RouteMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _coordinates = [NSMutableArray new];

    //22.7196° N, 75.8577° E
 
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.7196
                                                            longitude:75.8577
                                                                 zoom:10.0];
    [self.mapview animateToCameraPosition:camera];
  
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    
      [_coordinates addObject:[[CLLocation alloc] initWithLatitude:22.7196 longitude:75.8577]];
    
      [_coordinates addObject:[[CLLocation alloc] initWithLatitude:23.1793 longitude:75.7849]];
    
 
    
      [self getroute];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getroute{
    
    NSMutableArray *locationStrings = [NSMutableArray new];
    NSUInteger locationsCount = [_coordinates count];
    for (CLLocation *location in _coordinates)
    {
        [locationStrings addObject:[[NSString alloc] initWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude]];
    
        GMSMarker *marker = [GMSMarker markerWithPosition:location.coordinate];
        marker.title = [NSString stringWithFormat:@"you are here"];
        marker.appearAnimation = YES;
        marker.flat = YES;
        marker.snippet = @"";
        marker.icon = [UIImage imageNamed:@"map"];
        marker.map = self.mapview;
    }

    NSString *sensor = @"false";
    NSString *origin = [locationStrings objectAtIndex:0];
    NSString *destination = [locationStrings lastObject];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@origin=%@&destination=%@&sensor=%@", kDirectionsURL, origin, destination, sensor];
    
    if (locationsCount > 2)
    {
        [url appendString:@"&waypoints=optimize:false"];
        for (int i = 1; i < [locationStrings count] - 1; i++)
        {
            [url appendFormat:@"|%@", [locationStrings objectAtIndex:i]];
        }
    }
    
 
    url = [NSMutableString stringWithString:[url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    

 
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                            
                               
                                                                       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                               
                                                                             if (!error)
                                                                             {
                                                                                 NSArray *routesArray = [json objectForKey:@"routes"];
                               
                                                                                 if ([routesArray count] > 0)
                                                                                 {
                               
                                                                                     NSDictionary *routeDict = [routesArray objectAtIndex:0];
                                                                                     NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                                                                                     NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                                                                                     GMSPath *path = [GMSPath pathFromEncodedPath:points];
                                                                                     GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
                                                                                     polyline.strokeWidth = 2.f;
                                                                                     polyline.geodesic = YES;
                                                                                     polyline.map = self.mapview;
                                                                                     
                                                                                 }
                               
                                                                             }
                           }];
                           }





@end
