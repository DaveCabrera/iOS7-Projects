//
//  CityMapViewController.h
//  CitiesILike
//
//  Created by David Cabrera on 10/23/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"

@interface CityMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

/*
 [self.cityData objectAtIndex:0] = selectedCityName
 [self.cityData objectAtIndex:1] = selectedCountryName
 */
@property (strong, nonatomic) NSMutableArray *cityData;

@end