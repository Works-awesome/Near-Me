//
//  HomeViewController.h
//  Near ME APP
//
//  Created by Arjun Hanswal on 10/10/16.
//  Copyright © 2016 Com.BLE  TestApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface HomeViewController : UIViewController<CLLocationManagerDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UITableView *tablview;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
@property(nonatomic, retain) CLLocationManager *locationManager;
@end
