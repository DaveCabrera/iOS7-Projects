//
//  TopNavigationController.h
//  ACCSPorts
//
//  Created by David Cabrera on 10/8/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlidingViewController.h"
#import "MenuViewController.h"

@interface TopNavigationController : UINavigationController

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIButton *menu;

@end
