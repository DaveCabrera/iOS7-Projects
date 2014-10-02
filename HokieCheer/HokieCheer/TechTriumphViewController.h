//
//  TechTriumphViewController.h
//  HokieCheer
//
//  Created by David Cabrera on 9/17/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface TechTriumphViewController : UIViewController
// the audio player
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

// whenever play button is tapped
- (IBAction)playAudio:(UIBarButtonItem *)sender;

// whenever pause button is tapped
- (IBAction)pauseAudio:(UIBarButtonItem *)sender;

// whenver stop is tapped
- (IBAction)stopAudio:(UIBarButtonItem *)sender;
@end
