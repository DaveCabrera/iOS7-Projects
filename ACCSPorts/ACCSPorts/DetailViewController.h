//
//  DetailViewController.h
//  ACCSPorts
//
//  Created by David Cabrera on 10/8/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface DetailViewController : UIViewController <UIWebViewDelegate>


@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSString *websiteURL;

- (void)revealMenu:(id)sender;

- (void)homeButtonTapped:(id)sender;

@end
