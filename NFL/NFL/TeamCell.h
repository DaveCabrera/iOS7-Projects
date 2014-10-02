//
//  TeamCell.h
//  NFL
//
//  Created by David Cabrera on 10/21/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel      *teamCodeLabel;
@property (nonatomic, strong) IBOutlet UIImageView  *teamLogo;
@property (nonatomic, strong) IBOutlet UILabel      *teamNameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *divisionLabel;
@property (nonatomic, strong) IBOutlet UILabel      *stadiumLabel;
@end
