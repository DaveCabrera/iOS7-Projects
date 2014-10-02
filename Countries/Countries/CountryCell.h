//
//  CountryCell.h
//  Countries
//
//  Created by David Cabrera on 10/15/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel      *countryCodeLabel;
@property (nonatomic, strong) IBOutlet UIImageView  *flagImageView;
@property (nonatomic, strong) IBOutlet UILabel      *populationLabel;
@property (nonatomic, strong) IBOutlet UILabel      *capitalLabel;

@end
