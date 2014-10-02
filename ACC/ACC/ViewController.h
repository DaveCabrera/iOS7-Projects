//
//  ViewController.h
//  ACC
//
//  Created by David Cabrera on 9/24/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebsiteViewController.h"
@interface ViewController : UITableViewController

/*
 The accSports.plist XML file contains 3 dictionaries embedded into each other:
 
 Dictionary 1: Key = University Name    Value = object reference of Dictionary 2
 Dictionary 2: Key = Sport Category     Value = object reference of Dictionary 3
 Dictionary 3: Key = Sport Name         Value = sport's website URL
 */

@property (strong, nonatomic) NSDictionary *dict1_UniversityName_Dict2;
@property (strong, nonatomic) NSDictionary *dict2_SportCategory_Dict3;
@property (strong, nonatomic) NSDictionary *dict3_SportName_SportURL;

@property (strong, nonatomic) NSArray *universityNames;
@property (strong, nonatomic) NSArray *sportCategoryNames;
@property (strong, nonatomic) NSArray *sportNames;

/*
 The accUniversityLogos.plist XML file contains one dictionary:
 Dictionary: Key = University Name      Value = University Logo File Name
 */

@property (strong, nonatomic) NSDictionary *dict_UniversityName_UniversityLogoFileName;
@end
