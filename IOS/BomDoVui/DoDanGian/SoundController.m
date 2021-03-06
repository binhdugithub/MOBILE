//
//  SoundController.m
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/18/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//


#import "SoundController.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundController()
{
    AVAudioPlayer* m_AudioPlayerClickButton;
    AVAudioPlayer* m_AudioPlayerCorrect;
    AVAudioPlayer* m_AudioPlayerGameOver;
    AVAudioPlayer* m_AudioPlayerGameWin;
    BOOL m_IsMute;
}


@end


@implementation SoundController


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

- (NSString*) GetPathData: (NSString*)p_file
{
    NSString *destinationPath = [[NSSearchPathForDirectoriesInDomains(
                                                                      NSDocumentDirectory,
                                                                      NSUserDomainMask, YES
                                                                      ) objectAtIndex:0] stringByAppendingString:p_file];
    
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:p_file];
        NSError *error = nil;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        NSLog(@"Source: %@", sourcePath);
        NSLog(@"Destination: %@", destinationPath);
        // Check if any error occurred during copying and display it.
        
        if (error != nil)
        {
            NSLog(@"Copy file failed:%@", [error localizedDescription]);
        }
        else
        {
            
            NSLog(@"Copied data succesful!");
            
        }
    }
    else
    {
        NSLog(@"File destination: %@", destinationPath);
        NSLog(@"File exist");
    }
    
    return destinationPath;
    
}

- (void)LoadData
{
    NSString *pathData = [self GetPathData:@"/Data.plist"];
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
        m_IsMute = [dicData[@"IsMute"] boolValue];
    else
        NSLog(@"Load User info fail !!");
    
}

- (void) ChangeMute
{
    m_IsMute = (m_IsMute) ? FALSE : TRUE;
    NSString *pathData = [self GetPathData:@"/Data.plist"];
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