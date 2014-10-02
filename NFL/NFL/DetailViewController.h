//
//  DetailViewController.h
//  NFL
//
//  Created by David Cabrera on 10/22/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSString * websiteURL;
// The data object dataForSelectedTeam is passsed down from the previous view controller
@property (nonatomic, strong) NSArray *dataForSelectedTeam;
@end
