//
//  ViewController.m
//  Temperature
//
//  Created by David Cabrera on 9/3/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

- (IBAction)sliderChange:(UISlider *)sender {
    
    // make sure the parameter is of UISlider
    UISlider *slider = (UISlider *)sender;
    
    // slider uses floats, use .5 bump since it rounds down
    // convert to int
    int sliderIntValue = (int)([slider value] + 0.5f);
    
    // The label that will hold sliderIntValue to display on the screen
    NSString * newLabelText =[[NSString alloc] initWithFormat:@"%d°F", sliderIntValue];
    
    // Set the label on the screen to the new label text
    [[self sliderLabel] setText:newLabelText];
}
@end
