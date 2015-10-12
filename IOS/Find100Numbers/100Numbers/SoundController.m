//
//  SoundController.m
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "Configuration.h"
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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
        NSURL *mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerClickButton = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:nil];
        
        
        path = [[NSBundle mainBundle] pathForResource:@"gameover" ofType:@"mp3"];
        mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerGameOver = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:nil];
        
        path = [[NSBundle mainBundle] pathForResource:@"congratulation" ofType:@"mp3"];
        mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerGameWin = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:nil];
        
        path = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"mp3"];
        mp3URL = [NSURL fileURLWithPath:path];
        m_AudioPlayerCorrect = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:nil];
        
        //NSLog(@"%@", path);
    }
    
    
    return self;
}



- (void) ChangeMute
{
    BOOL l_IsMute = [[Configuration GetSingleton] GetIsMute];
    l_IsMute = (l_IsMute) ? FALSE : TRUE;
    
    [[Configuration GetSingleton] WriteMute:l_IsMute];
    
}

- (void) PlayClickButton
{
    if ([[Configuration GetSingleton] GetIsMute])
        return;
    
    //NSLog(@"Play click button");
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [m_AudioPlayerClickButton prepareToPlay];
    
    if([m_AudioPlayerClickButton play])
    {
       // NSLog(@"Play success");
    }
    else
    {
        //NSLog(@"Play fail!");
    }
    
}

- (BOOL) GetMute
{
    return [[Configuration GetSingleton] GetIsMute];
}

- (void) PlaySoundGameOver
{
    if ([[Configuration GetSingleton] GetIsMute])
        return;
    
    //NSLog(@"PlaySoundGameOver");
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [m_AudioPlayerGameOver prepareToPlay];
    [m_AudioPlayerGameOver play];
}

- (void) PlaySoundCongratulation
{
    if ([[Configuration GetSingleton] GetIsMute])
        return;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [m_AudioPlayerGameWin prepareToPlay];
    [m_AudioPlayerGameWin play];
}

- (void) PlaySoundCorrect
{
    if ([[Configuration GetSingleton] GetIsMute])
        return;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [m_AudioPlayerCorrect stop];
    [m_AudioPlayerCorrect prepareToPlay];
    [m_AudioPlayerCorrect play];
}


@end