//
//  BTTableViewController.h
//  Blacksburg
//
//  Created by David Cabrera on 9/27/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebsiteViewController.h"
#import "SchedulesAndMapsViewController.h"
@interface BTTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *btMenu;
@property (strong, nonatomic) NSString * btLogoLocation;
@property (strong, nonatomic) NSString * titleName;
@end
