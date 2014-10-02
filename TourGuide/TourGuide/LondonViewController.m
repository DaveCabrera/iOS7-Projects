//
//  LondonViewController.m
//  TourGuide
//
//  Created by David Cabrera on 9/19/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "LondonViewController.h"

@interface LondonViewController ()

@end

@implementation LondonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// called when the buton is tapped
- (IBAction)surveyButtonTapped:(UIButton *)sender {
    // Create the action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"How much do you like London?"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Very Much", @"Somewhat", @"Not so much", nil];
    
    // Display the action sheet
    [actionSheet showInView:self.view];
}

// called when the action sheet has a choise selected
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // The action sheet is automatically dismissed when this method is called
    switch (buttonIndex) {
        case 0:
            self.messageBox.text = @"You like London very much!";
            break;
        case 1:
            self.messageBox.text = @"You like London somewhat!";
            break;
        case 2:
            self.messageBox.text = @"You like London not so much!";
            break;
            
        default:
            break;
    }
}
@end
