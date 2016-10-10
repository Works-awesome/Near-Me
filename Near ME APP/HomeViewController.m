//
//  HomeViewController.m
//  Near ME APP
//
//  Created by Arjun Hanswal on 10/10/16.
//  Copyright © 2016 Com.BLE  TestApp. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end
NSArray *tabledata;
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tablview.hidden=YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];

    
    
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 800, 800);
    [self.mapview setRegion:[self.mapview regionThatFits:region] animated:YES];
    self.mapview.showsUserLocation = YES;
    
   
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = newLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapview addAnnotation:point];
     [self.locationManager stopUpdatingLocation];
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    
//    [geocoder reverseGeocodeLocation:newLocation // You can pass aLocation here instead
//                   completionHandler:^(NSArray *placemarks, NSError *error) {
//                       
//                       dispatch_async(dispatch_get_main_queue(),^ {
//                           // do stuff with placemarks on the main thread
//                           
//                           if (placemarks.count == 1) {
//                               
//                               CLPlacemark *placemark = [placemarks objectAtIndex:0];
//                               
//                               
//                               NSString *zipString = placemark.locality;
//                               //                               NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
//                               //                               NSLog(@"placemark.country %@",placemark.country);
//                               //                               NSLog(@"placemark.locality %@",placemark.locality );
//                               //                               NSLog(@"placemark.postalCode %@",placemark.postalCode);
//                               //                               NSLog(@"placemark.administrativeArea %@",placemark.administrativeArea);
//                               //                               NSLog(@"placemark.locality %@",placemark.locality);
//                               //                               NSLog(@"placemark.subLocality %@",placemark.subLocality);
//                               //                               NSLog(@"placemark.subThoroughfare %@",placemark.subThoroughfare);
//                             
//                               
//                           }
//                           
//                       });
//                       
//                   }];
}


- (IBAction)searchAction:(id)sender {
       self.tablview.hidden=NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return tabledata.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tabledata.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    
    cell.textLabel.text=[tabledata objectAtIndex:indexPath.row];
    
    return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    tabledata=[NSArray arrayWithObjects:@"vijay nagar",@"Geeta bhawan", nil];
    [self.tablview reloadData];
    
    return YES;

}

@end
