//
//  MasterViewController.h
//  NFL
//
//  Created by David Cabrera on 10/22/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "TeamCell.h"
#import "NFLWebViewController.h"
#define       kTableViewRowHeight  60;
@interface MasterViewController : UITableViewController
// Define MintCream color: #F5FFFA  245,255,250
#define MINT_CREAM [UIColor colorWithRed:245.0f/255.0f green:255.0f/255.0f blue:250.0f/255.0f alpha:1.0f];

// Define OldLace color: #FDF5E6   253,245,230
#define OLD_LACE [UIColor colorWithRed:253.0f/255.0f green:245.0f/255.0f blue:230.0f/255.0f alpha:1.0f];

/*
 The NFL.plist XML file represents a Dictionary data
 */
@property (nonatomic, strong) NSDictionary *nflDictionary;

@property (nonatomic, strong) NSArray *teamNicknames;

@property (nonatomic, strong) NSArray *teamData;

@property (strong, nonatomic) DetailViewController *detailViewController;
@end
