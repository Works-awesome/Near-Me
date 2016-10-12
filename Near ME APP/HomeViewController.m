//
//  HomeViewController.m
//  Near ME APP
//
//  Created by Arjun Hanswal on 10/10/16.
//  Copyright © 2016 Com.BLE  TestApp. All rights reserved.
//

#import "HomeViewController.h"
@import GooglePlaces;
#import <GooglePlaces/GooglePlaces.h>
@interface HomeViewController () <GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end
NSArray *tabledata;
@implementation HomeViewController{
 GMSPlacesClient *_placesClient;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _placesClient = [GMSPlacesClient sharedClient];
    
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



// Add a UIButton in Interface Builder, and connect the action to this function.
- (IBAction)getCurrentPlace:(UIButton *)sender {
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        self.nameLabel.text = @"No current place";
        self.addressLabel.text = @"";
        
        if (placeLikelihoodList != nil) {
            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
            if (place != nil) {
                self.nameLabel.text = place.name;
                
                self.addressLabel.text = [[place.formattedAddress componentsSeparatedByString:@", "]
                                          componentsJoinedByString:@"\n"];
                GMSMarker *marker = [GMSMarker markerWithPosition:place.coordinate];
                marker.title = [NSString stringWithFormat:@"%@",place.name];
                marker.appearAnimation = YES;
                marker.flat = YES;
                marker.snippet = @"";
                marker.icon = [UIImage imageNamed:@"map"];

                marker.map = self.mapview;
              
          
            
                
            }
        }
    }];

   

}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
                                                            longitude:newLocation.coordinate.longitude
                                                                 zoom:17.0];
    [self.mapview animateToCameraPosition:camera];
    
    self.mapview.settings.myLocationButton = YES;
    self.mapview.myLocationEnabled = YES;
    GMSMarker *marker = [GMSMarker markerWithPosition:newLocation.coordinate];
    marker.title = [NSString stringWithFormat:@"you are here"];
    marker.appearAnimation = YES;
    marker.flat = YES;
    marker.snippet = @"";
    marker.icon = [UIImage imageNamed:@"map"];
    marker.map = self.mapview;
    [self.locationManager stopUpdatingLocation];
    
}
- (void)mapView:(GMSMapView *)mapView
didTapPOIWithPlaceID:(NSString *)placeID
           name:(NSString *)name
       location:(CLLocationCoordinate2D)location {
    NSLog(@"You tapped %@: %@, %f/%f", name, placeID, location.latitude, location.longitude);
}
// Present the autocomplete view controller when the button is pressed.
- (IBAction)onLaunchClicked:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}


// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    GMSMarker *marker = [GMSMarker markerWithPosition:place.coordinate];
    marker.title = [NSString stringWithFormat:@"%@",place.name];
    marker.appearAnimation = YES;
    marker.flat = YES;
    marker.snippet = @"";
    marker.map = self.mapview;
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    NSLog(@"Place attributions %f,%f", place.coordinate.latitude, place.coordinate.longitude);
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude
                                                            longitude:place.coordinate.longitude
                                                                 zoom:17.0];
    [self.mapview animateToCameraPosition:camera];
    self.mapview.settings.myLocationButton = YES;
    self.mapview.myLocationEnabled = YES;
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
