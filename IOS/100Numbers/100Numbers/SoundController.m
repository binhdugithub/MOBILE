//
//  SoundController.m
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "SoundController.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundController()
@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayer;

@end


@implementation SoundController
@synthesize m_AudioPlayer;

- (id)init
{
    self = [super init];
    if (self)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
        NSURL *mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    }
    
    return self;
}


- (void) PlayClick
{
    [m_AudioPlayer play];
}


@end