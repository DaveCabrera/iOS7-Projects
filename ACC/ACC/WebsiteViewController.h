//
//  WebsiteViewController.h
//  ACC
//
//  Created by David Cabrera on 9/24/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebsiteViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSString *websiteURL;
@end
