//
//  Configuration.m
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 7/18/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "Configuration.h"
#import "Define.h"
#import <GameKit/GameKit.h>

@implementation Configuration

-(void)reportScore
{
    if(m_LeaderboardIdentifier != nil)
    {
        GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:m_LeaderboardIdentifier];
        score.value = m_BestScore;

        [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 NSLog(@"%@", [error localizedDescription]);
             }
         }];
    }
    else
    {
        NSLog(@"LeaderBoard failed");
    }
}

+(instancetype) GetSingleton
{
    static Configuration *ShareSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ShareSingleton = [[Configuration alloc] init];
    });
    
    return ShareSingleton;
};

- (id)init
{
    self = [super init];
    if(self)
    {
        [self LoadConfig];
        m_LeaderboardIdentifier = nil;
    }
    
    return self;
}


- (void) LoadConfig
{
    NSString *pathData = [self GetPathData];
    NSLog(@"data.plist: %@", pathData);
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        m_TimesPlayed = [dicData[@"TimesPlayed"] integerValue];
        if (m_TimesPlayed <= 0)
        {
            m_IsMute = FALSE;
            m_BestScore = 0;
            m_AverageScore = 0;
            m_TimesPlayed = 0;
        }
        else
        {
            
            m_BestScore = [dicData[@"BestScore"] integerValue];
            m_AverageScore = [dicData[@"AverageScore"] integerValue];
            m_TimesPlayed = [dicData[@"TimesPlayed"] integerValue];
            m_IsMute = [dicData[@"IsMute"] boolValue];
        }
        
    }
    else
    {
        NSLog(@"Load data.plist fail !!");
        m_BestScore = -1;
        m_AverageScore = -1;
        m_TimesPlayed = -1;
    }
}

- (void)ClearConfig
{
    NSString *pathData = [self GetPathData];
    NSLog(@"data.plist: %@", pathData);
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData] ;
    
    if (dicData != nil)
    {
        [dicData setObject:[NSNumber numberWithInt:0] forKey:@"BestScore"];
        [dicData setObject:[NSNumber numberWithInt:0] forKey:@"AverageScore"];
        [dicData setObject:[NSNumber numberWithInt:0] forKey:@"TimesPlayed"];
        [dicData writeToFile:pathData atomically:YES];
        
        m_BestScore = 0;
        m_TimesPlayed = 0;
        m_AverageScore = 0;
    }
    else
    {
        NSLog(@"Clear score fail!!");
    }
}

- (NSInteger) GetBestScore
{
    return m_BestScore;
}

- (NSInteger) GetTimesPlayed
{
    return m_TimesPlayed;
}

- (NSInteger) GetAverageScore
{
    return m_AverageScore;
}

- (BOOL) GetIsMute
{
    return m_IsMute;
}

- (NSString*) GetPathData
{
    NSString *destinationPath = [[NSSearchPathForDirectoriesInDomains(
                                                                      NSDocumentDirectory,
                                                                      NSUserDomainMask, YES
                                                                      ) objectAtIndex:0] stringByAppendingString:FILECONFIG];
    
    // NSLog(@"File path: %@", destinationPath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath])
    {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:FILECONFIG];
        NSError *error = nil;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        NSLog(@"Copied data plist");
        NSLog(@"Source: %@", sourcePath);
        NSLog(@"Destination: %@", destinationPath);
    }
    else
    {
        NSLog(@"File exist");
    }
    
    return destinationPath;
    
}

- (void) WriteMute : (BOOL) p_ismute
{
    NSLog(@"Writemute");
    
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        
        [dicData setObject:[NSNumber numberWithBool:p_ismute] forKey:@"IsMute"];
        [dicData writeToFile:pathData atomically:YES];
        
        m_IsMute = p_ismute;
        
    }
    else
    {
        NSLog(@"Load data plist info fail !!");
    }
    
};

- (void) UpdateStatistics : (NSInteger) p_currentscore
{
    NSLog(@"WriteTimesPlayed");
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        NSInteger l_OldTimesPlayed = [dicData[@"TimesPlayed"] integerValue];
        NSInteger l_OldAverage = [dicData[@"AverageScore"] integerValue];
        m_TimesPlayed = l_OldTimesPlayed + 1;
        m_AverageScore = ( l_OldAverage * l_OldTimesPlayed + p_currentscore) / m_TimesPlayed;
        m_BestScore = [dicData[@"BestScore"] integerValue];
       
        [dicData setObject:[NSNumber numberWithInteger:m_AverageScore] forKey:@"AverageScore"];
        [dicData setObject:[NSNumber numberWithInteger:m_TimesPlayed] forKey:@"TimesPlayed"];
        if (p_currentscore > m_BestScore)
        {
            [dicData setObject:[NSNumber numberWithInteger: p_currentscore] forKey:@"BestScore"];
            m_BestScore = p_currentscore;
        }
        
        NSLog(@"Report score");
        [self reportScore];
        
        
        [dicData writeToFile:pathData atomically:YES];
    }
    else
    {
        NSLog(@"Load data.plist fail !!");
    }
};

- (void) WriteBestScore : (NSInteger) p_bestscore
{
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        [dicData setObject:[NSNumber numberWithInteger: p_bestscore] forKey:@"BestScore"];
        [dicData writeToFile:pathData atomically:YES];
        
    }
    else
    {
        NSLog(@"Load data.plist fail !!");
    }
};

- (void) WriteAverageScore: (NSInteger) p_averagescore
{
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        [dicData setObject:[NSNumber numberWithInteger: p_averagescore] forKey:@"AverageScore"];
        [dicData writeToFile:pathData atomically:YES];
        
    }
    else
    {
        NSLog(@"Load data.plist fail !!");
    }
    
};


- (void) SetLeaderboardIdentifier : (NSString*) p_leaderboard
{
    m_LeaderboardIdentifier = p_leaderboard;
}


@end
