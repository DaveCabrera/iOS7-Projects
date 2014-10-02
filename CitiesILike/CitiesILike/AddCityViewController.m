//
//  AddCityViewController.m
//  CitiesILike
//
//  Created by David Cabrera on 10/23/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "AddCityViewController.h"

@interface AddCityViewController ()

@end

@implementation AddCityViewController

- (void)viewDidLoad
{
    // Instantiate a Save button to invoke the save: method when tapped
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                   target:self action:@selector(save:)];
    
    // Set up the Save custom button on the right of the navigation bar
    self.navigationItem.rightBarButtonItem = saveButton;
}


- (IBAction)keyboardDone:(id)sender
{
    [sender resignFirstResponder];  // Deactivate the keyboard
}


- (void)save:(id)sender
{
    // Inform the delegate that the user tapped the Save button
    [self.delegate addCityViewController:self didFinishWithSave:YES];
}

@end

