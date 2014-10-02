//
//  ViewController.h
//  Temperature
//
//  Created by David Cabrera on 9/3/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *sliderLabel;

- (IBAction)sliderChange:(UISlider *)sender;
@end
