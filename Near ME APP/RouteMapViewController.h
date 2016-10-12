//
//  RouteMapViewController.h
//  Near ME APP
//
//  Created by Arjun Hanswal on 10/10/16.
//  Copyright © 2016 Com.BLE  TestApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@import AFNetworking;

@interface RouteMapViewController : UIViewController <GMSMapViewDelegate>
{
   
   

        NSMutableArray *_coordinates;
        __weak GMSMapView *_mapView;
      
        GMSPolyline *_polyline;
        GMSMarker *_markerStart;
        GMSMarker *_markerFinish;
    }

@property (weak, nonatomic) IBOutlet GMSMapView *mapview;

@end
