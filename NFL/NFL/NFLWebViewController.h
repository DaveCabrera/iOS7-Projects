//
//  NFLWebViewController.h
//  NFL
//
//  Created by David Cabrera on 10/21/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFLWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *websiteURL;
@property (nonatomic, strong) NSString *teamName;
@end
