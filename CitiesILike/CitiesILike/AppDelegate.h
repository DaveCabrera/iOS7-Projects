//
//  AppDelegate.h
//  CitiesILike
//
//  Created by David Cabrera on 10/23/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// Global Data countryCities is used by classes in this project
@property (strong, nonatomic) NSMutableDictionary *countryCities;

@end

