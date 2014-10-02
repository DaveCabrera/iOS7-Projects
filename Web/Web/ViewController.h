//
//  ViewController.h
//  Web
//
//  Created by David Cabrera on 9/11/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

// Since we identified the View Controller class as the delegates for the text field
// and the WebViewDelegate
@interface ViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>

// variable pointing to the webview
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end
