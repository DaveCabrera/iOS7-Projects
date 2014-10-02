//
//  ViewController.h
//  CitiesILike
//
//  Created by David Cabrera on 10/23/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityViewController.h"
#import "CityMapViewController.h"
#import "AppDelegate.h"

@class AppDelegate;


@interface CityViewController : UITableViewController <AddCityViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *countryCityTableView;

@end
