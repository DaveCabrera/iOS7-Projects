//
//  TurkeyGobbleViewController.m
//  HokieCheer
//
//  Created by David Cabrera on 9/17/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "TurkeyGobbleViewController.h"

@interface TurkeyGobbleViewController ()

@end

@implementation TurkeyGobbleViewController

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
    // Obtain the URL path to the hokie gobble sound file, turkeyGobble.wav.
    NSURL *soundFilePath = [[NSBundle mainBundle] URLForResource: @"turkeyGobble" withExtension: @"wav"];
    
    // Casting Objective-C pointer type "NSURL *" to C pointer type CFURLRef requires a bridged cast.
    self.soundFileURLRef = (__bridge CFURLRef) soundFilePath;
    
    /*
     Create a system sound object for the short sound (30 seconds or shorter) in file turkeyGobble.wav
     
     Load the turkey gobble sound file into memory from its file and store the assigned
     identifier in the _turkeyGobbleSoundID instance variable.
     
     & is a unary operator known as the Address Operator. It basically represents
     two-level indirection. &_turkeyGobbleSoundID points to another pointer that contains
     the memory address of the sound; hence, double pointers or double indirection.
     
     AudioServicesCreateSystemSoundID is a C programming language function, which takes
     self.soundFileURLRef as input and provides the value of &_turkeyGobbleSoundID as output.
     */
    AudioServicesCreateSystemSoundID (self.soundFileURLRef, &_turkeyGobbleSoundID);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    if (self.turkeyGobbleSoundID) {
        /*
         Call the C programming language function AudioServicesDisposeSystemSoundID with
         input value of instance variable _turkeyGobbleSoundID that points to the system
         sound object to dispose of the sound object and its associated resources.
         */
        AudioServicesDisposeSystemSoundID(_turkeyGobbleSoundID);
    }
    
    [super viewDidUnload];
}

// when using c functions, call dealloc to release from memory
- (void)dealloc
{
    if (self.turkeyGobbleSoundID) {
        /*
         Call the C programming language function AudioServicesDisposeSystemSoundID with
         input value of instance variable _turkeyGobbleSoundID that points to the system
         sound object to dispose of the sound object and its associated resources.
         */
        AudioServicesDisposeSystemSoundID(_turkeyGobbleSoundID);
    }
}

/*
 The TurkeyGobbleViewController object must be the first responder to be able to receive
 and handle motion events. The following two instance methods are used for this purpose.
 */

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

// This method plays the turkey gobble sound if the detected motion is a shaking motion

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // If the detected motion is a shaking motion
    if (motion == UIEventSubtypeMotionShake) {
        
        // Then, play the turkey gobble sound
        AudioServicesPlaySystemSound (_turkeyGobbleSoundID);
    }
}

@end
