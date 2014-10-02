//
//  TechTriumphViewController.m
//  HokieCheer
//
//  Created by David Cabrera on 9/17/13.
//  Copyright (c) 2013 David Cabrera. All rights reserved.
//

#import "TechTriumphViewController.h"

@interface TechTriumphViewController ()

@end

@implementation TechTriumphViewController

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

- (void)viewWillAppear:(BOOL)animated {
    /*
     Just before the view becomes visible to the user,
     create an audio player object with the keyPlay.wav audio file.
     */
    
    // Obtain the URL path to the sound file keyPlay.wav.
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource: @"techTriumph" withExtension: @"wav"];    
    // Instantiate an audio player object and initialize it with the keyPlay.wav audio file.
    // Store newly created audio player's object reference into the instance variable _audioPlayer
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
}

// Whenever the play button is tapped, do the following
- (IBAction)playAudio:(UIBarButtonItem *)sender {
    [[self audioPlayer] play];
}

// Whenever the pause button is tapped, pause the audio
- (IBAction)pauseAudio:(UIBarButtonItem *)sender {
    [[self audioPlayer] pause];
}

// Whenever the stop button is tapped, pause the audio
- (IBAction)stopAudio:(UIBarButtonItem *)sender {
    [[self audioPlayer] stop];
    
    // Set the playback point in time to 0 second; that is, bring the audio to its beginning.
    self.audioPlayer.currentTime = 0;
}

-(void) viewWillDisappear:(BOOL)animated {
    // Just before the view is dismissed, covered, or otherwise hidden, stop the audio playing.
    [self.audioPlayer stop];
    
    // Drop the object reference to audioPlayer
    self.audioPlayer = nil;
}
@end
