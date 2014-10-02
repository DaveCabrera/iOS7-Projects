//
//  CityWebViewController.h
//  CitiesILike
//
//  Created by David Cabrera on 10/23/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

/*
 [self.cityData objectAtIndex:0] = selectedCityName
 [self.cityData objectAtIndex:1] = selectedCountryName
 */
@property (strong, nonatomic) NSMutableArray *cityData;

@end
