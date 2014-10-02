//
//  LondonViewController.h
//  TourGuide
//
//  Created by David Cabrera on 9/19/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LondonViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UILabel *messageBox;

- (IBAction)surveyButtonTapped:(UIButton *)sender;
@end
