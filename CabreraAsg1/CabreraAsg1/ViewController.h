//
//  ViewController.h
//  CabreraAsg1
//
//  Created by David Cabrera on 9/8/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
# import "BMICalculator.h"
@interface ViewController : UIViewController <UITextFieldDelegate>

// Reference variables for some UI Objects
@property (strong, nonatomic) IBOutlet UILabel *weightSliderLabel;
@property (strong, nonatomic) IBOutlet UITextField *feetTextField;
@property (strong, nonatomic) IBOutlet UITextField *inchesTextField;
@property (strong, nonatomic) IBOutlet UITextField *metersTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *unitSegmentControl;
@property (strong, nonatomic) IBOutlet UILabel *bmiResultLabel;
@property (strong, nonatomic) IBOutlet UISlider *weightSlider;



// Below are actions for the buttons, slider, and segment control
- (IBAction)resetButtonTouched:(UIButton *)sender;
- (IBAction)computeButtonTouched:(UIButton *)sender;
- (IBAction)weightSliderChange:(UISlider *)sender;
- (IBAction)unitSegmentControlChange:(UISegmentedControl *)sender;



@end
