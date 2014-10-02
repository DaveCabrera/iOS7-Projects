//
//  ViewController.m
//  CabreraAsg1
//
//  Created by David Cabrera on 9/8/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (BOOL) doesStringHaveLetter: (NSString *) string;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The reset button on the user interface was touched by the user.
- (IBAction)resetButtonTouched:(UIButton *)sender {
    
    // reset the height text fields
    [[self feetTextField] setText:@""];
    [[self inchesTextField] setText:@""];
    [[self metersTextField] setText:@""];
    
    // reset the segment control
    // Use UISegmentedControlNoSegment to clear
    [[self unitSegmentControl] setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    // reset the slider label and slider
    [[self weightSliderLabel] setText:@"100"];
    [[self weightSlider] setValue:100];
    
    // reset the bmi label
    [[self bmiResultLabel] setText:@""];
}

// Compute the BMI when the button is touched
- (IBAction)computeButtonTouched:(UIButton *)sender {
    
    ////INPUT VALIDATION
    // Check if the (feet and inches) box is empty
    // check if the meters box is empty
    if (([[self feetTextField] text].length == 0 || [[self inchesTextField]text].length == 0) && [[self metersTextField] text].length == 0)
    {
        
        // Create the Alert View
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your height is missing!"
                                                        message:@"Please enter your height, either in feet and inches or in meters."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        
        // Display the Alert View
        [alert show];
    }
    else if ([[[self feetTextField]text] doubleValue] > 7.0 || [[[self inchesTextField]text] doubleValue] >= 12.0 || [[[self metersTextField]text] doubleValue] > 2.2)
    {
        // Create the Alert View
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Height is Too High!"
                                                        message:@"Please enter an acceptable height"
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        
        // Display the Alert View
        [alert show];

    }
    else if ( ([self doesStringHaveLetter:self.feetTextField.text] == YES || [self doesStringHaveLetter:self.inchesTextField.text] == YES) && [self doesStringHaveLetter:self.metersTextField.text] == YES)
    {
        // Create the Alert View
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not a Number!"
                                                        message:@"Please enter only numbers for your height."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        
        // Display the Alert View
        [alert show];
    }
    else if ([[self unitSegmentControl] selectedSegmentIndex] == UISegmentedControlNoSegment)
    {
        // Create the Alert View
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Weight Unit Selected!"
                                                        message:@"Please select Pounds or Kilograms"
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        
        // Display the Alert View
        [alert show];

    }
    else if ([[self feetTextField] text].length > 0 && [[self inchesTextField]text].length > 0 && [[self metersTextField] text].length > 0)
    {
        // Create the Alert View
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unit Conflict!"
                                                        message:@"Both Feet/Inches and meters are entered. Please use only one unit."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        
        // Display the Alert View
        [alert show];
    }
    else
    {
        // get the text from the imperial text boxes
        double feet = [[[self feetTextField] text] doubleValue];
        double inches = [[[self inchesTextField] text] doubleValue];
        
        // get the text from the metric boxes
        double meters = [[[self metersTextField] text] doubleValue];
        
        // get the weight, will be a double
        double weight = [[[self weightSliderLabel] text] doubleValue];
        
        // the compute button is touched, we create a new BMI object
        // and the BMI object is going to do the calculation for us
        BMICalculator *calculator = [[BMICalculator alloc] init];
        
        // since the user can specigy the height in one unit and weight
        // in another, check the weight unit and use the empty boxes.
        
        // if it is in pounds,
        if ([[self unitSegmentControl] selectedSegmentIndex] == 0)
        {
            // if the imperial units are filled use them
            // otherwise meters are used and the weight is converted to metric
            if ([[self feetTextField] text].length > 0 && [[self inchesTextField] text].length > 0) {
                calculator.heightInFeet = feet;
                calculator.heightInInches = inches;
                calculator.weight = weight;
                [calculator convertWeightToMetric];
                [calculator convertHeightToMetric];
            }
            else
            {
                calculator.heightInMeters = meters;
                calculator.weight = weight;
                [calculator convertWeightToMetric];
            }
        }
        // if it's in metric
        if ([[self unitSegmentControl] selectedSegmentIndex] == 1)
        {
            // if the imperial units are filled use them (and convert them to metric only)
            // otherwise meters are used and the weight is not converted
            if ([[self feetTextField] text].length > 0 && [[self inchesTextField] text].length > 0) {
                calculator.heightInFeet = feet;
                calculator.heightInInches = inches;
                calculator.weight = weight;
                [calculator convertHeightToMetric];
            }
            else
            {
                calculator.heightInMeters = meters;
                calculator.weight = weight;
            }
        }
        
        NSString *result = [calculator calculateBMI];
        
        // set the bmi label to the result
        [[self bmiResultLabel] setText:result];

    }
}

// Whenever the weight slider is changed the weightSlider label is updated
// with the slider label
- (IBAction)weightSliderChange:(UISlider *)sender {
    // make sure the parameter is of UISlider
    UISlider *slider = (UISlider *)sender;
    NSLog(@"%f", [slider value]);
    
    // once we have the slider value,
    // we need to update the slider label to update the label
    // according to what is currently selected (Pounds or Kilograms)
    if ([[self unitSegmentControl]selectedSegmentIndex] == 0 || [[self unitSegmentControl] selectedSegmentIndex] == 1)
    {
        // create a number from the float
        // convert to double
        // set the new text
        NSNumber *number = [[NSNumber alloc] initWithFloat:[slider value]];
        double sliderDoubleValue = [number doubleValue];
        NSString *newLabelText = [[NSString alloc] initWithFormat:@"%1.2f", sliderDoubleValue];
        self.weightSliderLabel.text = nil;
        [[self weightSliderLabel] setText:newLabelText];
    }
    else
    {
        // slider uses floats, use .5 bump since it rounds down
        // convert to int
        int sliderIntValue = (int)([slider value] + 0.5f);
        
        // The label that will hold sliderIntValue to display on the screen
        NSString * newLabelText =[[NSString alloc] initWithFormat:@"%d", sliderIntValue];
        
        // Set the label on the screen to the new label text
        [[self weightSliderLabel] setText:newLabelText];    }
}

// change the units when the selector is changed between pounds and kilograms
- (IBAction)unitSegmentControlChange:(UISegmentedControl *)sender {
    
    // get the current value of the text
    // convert the current text to a double
    // create the new text and set the label
    NSString *currentText = [[self weightSliderLabel] text];
    double currentTextNumber = [currentText doubleValue];
    NSString *newLabelText = [[NSString alloc] initWithFormat:@"%1.2f", currentTextNumber];
        
    self.weightSliderLabel.text = nil;
    [[self weightSliderLabel] setText:newLabelText];
}

// This method is called after the user taps the "Done" button
// on the keyboard.
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // Deactivate the text field so it is no longer the currently
    // selected/active UI object
    [textField resignFirstResponder];
    return YES;
}

// The following code snippet is adapted from a stackoverflow answer found here
// stackoverflow.com/questions/7129146/how-to-check-if-a-string-contains-english-letters-a-z
- (BOOL) doesStringHaveLetter: (NSString *) string
{
    // Create a regular expression to detect everything with numbers
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"^[0-9]" options:0 error:NULL];
    
    // Cross reference with the string
    NSUInteger matches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    // return no if there are no letters
    
    NSLog(@"%@ has Matches %lu", string, (unsigned long)matches);
    if (matches > 0)
    {
        return NO;
    }
    return YES;
}
@end
