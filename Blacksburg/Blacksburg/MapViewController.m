//
//  MapViewController.m
//  Blacksburg
//
//  Created by David Cabrera on 9/27/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // set the map to the default standard type
    self.map.mapType = MKMapTypeStandard;
    
    [self displayMap];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // inform super
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// tells the view what position the map needs to be
- (void) displayMap
{
    // A structure that defines which portion of the map to display
    MKCoordinateRegion blacksburgVaRegion;
    
    blacksburgVaRegion.center.latitude = 37.230635913525525;        // Latitude for Blacksburg, VA
    blacksburgVaRegion.center.longitude =  -80.41528701782227;      // Longitude for Blacksburg, VA
    
    /*
     "The amount of north-to-south distance (measured in degrees) to display on the map. Unlike longitudinal distances,
     which vary based on the latitude, one degree of latitude is always approximately 111 kilometers (69 miles)." [Apple]
     */
    blacksburgVaRegion.span.latitudeDelta = 0.025;   // Set the span to about 0.025 x 69 miles = 1.725 miles
    
    /*
     "The amount of east-to-west distance (measured in degrees) to display for the map region. The number of kilometers
     spanned by a longitude range varies based on the current latitude. For example, one degree of longitude spans a
     distance of approximately 111 kilometers (69 miles) at the equator but shrinks to 0 kilometers at the poles." [Apple]
     */
    blacksburgVaRegion.span.longitudeDelta = 0.025;   // Set the span to about 0.025 x 69 miles = 1.725 miles
    
    // Ask the map object to display the map as defined by blacksburgVaRegion
    [[self map] setRegion:blacksburgVaRegion animated:YES];
}

// Action to take once the standard button is pressed
- (IBAction)standardButton:(UIBarButtonItem *)sender {
    self.map.mapType = MKMapTypeStandard;
}

// Action to take once the satellite button is pressed
- (IBAction)satelliteButton:(UIBarButtonItem *)sender {
    self.map.mapType = MKMapTypeSatellite;
}

// Action to take once the hybrid button is pressed
- (IBAction)hybridButton:(UIBarButtonItem *)sender {
    self.map.mapType = MKMapTypeHybrid;
}
@end
