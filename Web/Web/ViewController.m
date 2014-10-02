//
//  ViewController.m
//  Web
//
//  Created by David Cabrera on 9/11/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// private properties, methods, and variables declared here
@end

@implementation ViewController

- (void)viewDidLoad
{
    // when we start the application, we want the app to show the default url in the text field
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This method is called after the user taps the "Go" button
// The text is examined and if it doesn't start with an http://
// it is inserted, otherwise it is sent to the webview to load the page
// Must be implemented since the ViewController is the designated delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // Deactivate the text field so it is no longer the currently
    // selected/active UI object
    [textField resignFirstResponder];
    
    // Retrieve the url from the text field
    NSString * urlText = [textField text];
    
    // Prefix for the url
    NSString * httpString = @"http://";
    
    // Determine if the string needs modification
    // Then load the page
    if ([urlText hasPrefix:httpString])
    {
        [[self webView] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlText]]];
    }
    else
    {
        NSString * newURLText = [httpString stringByAppendingString:urlText];
        [[self webView] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newURLText]]];
    }
    
    return YES;
}

// Must be implemented since the ViewController is the designated delegate for the Web View
// Called when the web view starts to load the web page
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    // Show the animated activity indicator in the status bar to let
    // the user know the page is loading
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// Must be implemented since the ViewController is the designated delegate for the Web View
// Called when the web view finished loading the web page
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    // Hide the activity indicator once the page finishes loading
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// Must be implemented since the ViewController is the designated delegate for the Web View
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // An error occured while the web page is loading, hide the activity indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // Create the error message in HTML as a character string object pointed to by errorString
    NSString *errorString = [NSString stringWithFormat:@"<html><font size=+2 color='red'><p>An error occurred: %@<br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>",
                             error.localizedDescription];
    
    // display the error
    [[self webView] loadHTMLString:errorString baseURL:nil];
}
@end
