//
//  TurkeyGobbleViewController.h
//  HokieCheer
//
//  Created by David Cabrera on 9/17/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@interface TurkeyGobbleViewController : UIViewController

// variable that will point to the location in memory that contains the audio file
@property (readonly) SystemSoundID turkeyGobbleSoundID;

// provides facilities for creating,parsing, and dereferencing URL strings
@property (readwrite) CFURLRef soundFileURLRef;
@end
