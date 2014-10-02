//
//  ArtsViewController.h
//  Blacksburg
//
//  Created by David Cabrera on 9/29/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArtsViewController : UIViewController
@property (strong, nonatomic) NSString *websiteURL;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end
