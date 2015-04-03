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
@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayerClickButton;
@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayerCorrect;
@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayerGameOver;
@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayerGameWin;
@property (nonatomic, assign) BOOL m_IsMute;

@end


@implementation SoundController
@synthesize m_AudioPlayerClickButton, m_AudioPlayerCorrect, m_AudioPlayerGameOver, m_AudioPlayerGameWin;
@synthesize m_IsMute;

+(instancetype) GetSingleton
{
    static SoundController *ShareSounder = nil ;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        ShareSounder = [[SoundController alloc] init] ;
    });
    
    return ShareSounder ;
}


-(id)init
{
    
    self = [super init];
    if(self)
    {
        [self LoadData];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
        NSURL *mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerClickButton = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
     
        
        path = [[NSBundle mainBundle] pathForResource:@"gameover" ofType:@"mp3"];
        mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerGameOver = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
        
        path = [[NSBundle mainBundle] pathForResource:@"congratulation" ofType:@"mp3"];
        mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerGameWin = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
        
        path = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"mp3"];
        mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerCorrect = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    }
    
    
    return self;
}


- (void)LoadData
{
    NSString *pathData = [[NSBundle mainBundle] pathForResource: @"Data" ofType:@"plist"];
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
        m_IsMute = [dicData[@"IsMute"] boolValue];
    else
        NSLog(@"Load User info fail !!");
    
}

- (void) ChangeMute
{
    m_IsMute = (m_IsMute) ? FALSE : TRUE;
    NSString *pathData = [[NSBundle mainBundle] pathForResource: @"Data" ofType:@"plist"];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        
        [dicData setObject:[NSNumber numberWithInt:m_IsMute] forKey:@"IsMute"];
        [dicData writeToFile:pathData atomically:YES];
        
    }
    else
    {
        NSLog(@"Load User info fail !!");
    }
    
}

- (BOOL) GetMute
{
    return m_IsMute;
}

- (void) PlayClickButton
{
    if (m_IsMute)
        return;
    
    [m_AudioPlayerClickButton play];
}

- (void) PlaySoundGameOver
{
    if(m_IsMute)
        return;
    
    [m_AudioPlayerGameOver play];
}

- (void) PlaySoundCongratulation
{
    if(m_IsMute)
        return;

    [m_AudioPlayerGameWin play];
}

- (void) PlaySoundCorrect
{
    if(m_IsMute)
        return;
    [m_AudioPlayerCorrect play];
}


@end