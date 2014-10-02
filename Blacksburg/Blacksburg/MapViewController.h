//
//  MapViewController.h
//  Blacksburg
//
//  Created by David Cabrera on 9/27/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController

// property for the map
@property (strong, nonatomic) IBOutlet MKMapView *map;

// property for the buttons on the toolbar
- (IBAction)standardButton:(UIBarButtonItem *)sender;
- (IBAction)satelliteButton:(UIBarButtonItem *)sender;
- (IBAction)hybridButton:(UIBarButtonItem *)sender;

// methods we wish to implement
- (void) displayMap;
@end
