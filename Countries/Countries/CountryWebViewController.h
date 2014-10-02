//
//  CountryWebViewController.h
//  Countries
//
//  Created by David Cabrera on 10/15/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *websiteURL;
@property (nonatomic, strong) NSString *countryName;

@end
