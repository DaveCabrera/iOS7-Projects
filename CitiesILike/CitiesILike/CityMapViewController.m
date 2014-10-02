//
//  CityMapViewController.m
//  CitiesILike
//
//  Created by David Cabrera on 10/23/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "CityMapViewController.h"

@interface CityMapViewController ()

@end


@implementation CityMapViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    // Obtain the selected city name
    NSString *selectedCityName = [self.cityData objectAtIndex:0];
    
    // Set the title of the view controller to the selected city name
    self.title = selectedCityName;
    
    // Obtain the selected country name
    NSString *selectedCountryName = [self.cityData objectAtIndex:1];
    
    /*
     MKCoordinateSpan is a structure that defines the area spanned by a map region.
     
     typedef struct {
     CLLocationDegrees latitudeDelta;
     CLLocationDegrees longitudeDelta;
     } MKCoordinateSpan;
     
     */
    MKCoordinateSpan span;
    
    /*
     latitudeDelta: The amount of north-to-south distance (measured in degrees) to display on the map. Unlike longitudinal distances,
     which vary based on the latitude, one degree of latitude is always approximately 111 kilometers (69 miles).
     longitudeDelta: The amount of east-to-west distance (measured in degrees) to display for the map region. The number of kilometers
     spanned by a longitude range varies based on the current latitude. For example, one degree of longitude spans a distance of
     approximately 111 kilometers (69 miles) at the equator but shrinks to 0 kilometers at the poles.
     */
    
    span.latitudeDelta  = 2;  // Set the span latitude  delta to 2 degrees, i.e., 2 x 111 kilometers (69 miles)
    span.longitudeDelta = 2;  // Set the span longitude delta to 2 degrees, i.e., 2 x 111 kilometers (69 miles)
    
    
    // Declare geocoder as an object reference pointing to a geolocation object
    CLGeocoder *geocoder;
    
    /**************** FORWARD GEOCODING LOCATION DATA ******************************
     Geocoder Objects
     
     A geocoder object uses a network service to convert between latitude and longitude values and a user-friendly placemark,
     which is a collection of data such as the street, city, state, and country information. Reverse geocoding is the process
     of converting a latitude and longitude into a placemark. Forward geocoding is the process of converting place name information
     into a latitude and longitude value. Reverse geocoding is supported in all versions of iOS but forward geocoding is supported
     only in iOS 5.0 and later.
     
     http://developer.apple.com/library/ios/#documentation/userexperience/conceptual/LocationAwarenessPG/UsingGeocoders/UsingGeocoders.html
     
     Converting Place Names Into Coordinates
     
     In iOS 5.0 and later, you use the CLGeocoder class to initiate forward-geocoding requests using either a dictionary of Address Book
     information or a simple string. There is no designated format for string-based requests; delimiter characters are welcome, but not
     required, and the geocoder server treats the string as case-insensitive. Therefore, any of the following strings would yield results:
     
     "Apple Inc”
     "1 Infinite Loop”
     "1 Infinite Loop, Cupertino, CA USA”
     
     The more information you can provide to the forward geocoder, the better the results returned to you. The geocoder object parses the
     information you give it and, if it finds a match, returns some number of placemark objects. The number of returned placemark objects
     depends greatly on the specificity of the information provided. Thus, providing street, city, province, and country information is much
     more likely to return a single address than just street and city information. The completion handler block you pass to the geocoder
     should therefore be prepared to handle multiple placemarks, as shown below.
     *****************************************************************************/
    
    if (!geocoder) {
        
        geocoder = [[CLGeocoder alloc] init];
        
        // Obtain the "selectedCityName, selectedCountryName" to query Apple map API (spaces are okay unlike Google query)
        NSString *selectedCityCountry = [[NSString alloc] initWithFormat:@"%@,%@", selectedCityName, selectedCountryName];
        
        /* The carat symbol ^ in Objective-C represents Block Objects. See the following URL for details.
         
         Blocks Programming Topics
         http://developer.apple.com/library/ios/#documentation/cocoa/Conceptual/Blocks/Articles/00_Introduction.html
         */
        
        [geocoder geocodeAddressString:selectedCityCountry completionHandler:^(NSArray *placemarks, NSError *error)
         
         // The completionHandler block starts here. The carat symbol ^ above indicates that we specify the value of
         // the completionHandler parameter by a block object, which is defined below between { and }.
         {
             MKCoordinateRegion region;
             
             // We assume that the first object in the placemarks array returned is the geolocation we want
             CLPlacemark *aPlacemark = [placemarks objectAtIndex:0];
             
             // Set the span and the center of the map region to display
             region.span = span;
             region.center = aPlacemark.location.coordinate;
             
             // Ask the map view object to display the defined map region in an animated way
             [self.mapView setRegion:region animated:YES];
             
             // Ask the map view object to display the map region as fitting to the map frame
             [self.mapView regionThatFits:region];
             
         }  // The completionHandler block ends here
         
         ];
    }
    
    [super viewDidLoad];
}


#pragma mark - MKMapViewDelegate Protocol Methods


- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    // Show the animated activity indicator in the status bar while the map is being loaded
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    // Hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    // Hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // Compose the error message
    NSString *errorMessage = [NSString stringWithFormat:
                              @"Problem Description: %@", error.localizedDescription];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unable to Load Map"
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end