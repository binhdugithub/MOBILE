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

-(void)ReportScore
{
    if(m_LeaderboardIdentifier != nil)
    {
        GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:m_LeaderboardIdentifier];
        score.value = m_Level;
        
        [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 NSLog(@"%@", [error localizedDescription]);
             }
             else
             {
                 NSLog(@"Write game center succesful");
             }
         }];
    }
    else
    {
        NSLog(@"LeaderBoard failed");
    }
}

- (void) SetLeaderboardIdentifier : (NSString*) p_leaderboard
{
    m_LeaderboardIdentifier = p_leaderboard;
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
    //NSLog(@"data.plist: %@", pathData);
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
       
        m_IsMute = [dicData[@"IsMute"] boolValue];
        m_Score = [dicData[@"Score"] integerValue];
        m_Level = [dicData[@"Level"] integerValue];
        
    }
    else
    {
        NSLog(@"Load Data.plist fail !!");
        m_IsMute = FALSE;
        m_Score = 0;
        m_Level = 0;
    }
}


- (BOOL) GetIsMute
{
    return m_IsMute;
}

- (NSInteger) GetScore
{
    return m_Score;
}

- (void) WriteScore : (NSInteger) p_socre
{
    {
    
        NSString *pathData = [self GetPathData];
        NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
        if (dicData != nil)
        {
            
            [dicData setObject:[NSNumber numberWithInteger:p_socre] forKey:@"Score"];
            [dicData writeToFile:pathData atomically:YES];
            m_Score = p_socre;
            
            NSLog(@"Best new score: %li", (long)m_Score);
            
        }
        else
        {
            NSLog(@"Load Data plist info fail !!");
        }
    }
}

- (NSInteger) GetLevel
{
    return m_Level;
}

- (void) WriteLevel : (NSInteger) p_level
{
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        
        [dicData setObject:[NSNumber numberWithInteger:p_level] forKey:@"Level"];
        [dicData writeToFile:pathData atomically:YES];
        m_Level = p_level;
        
        NSLog(@"Score new: %li", (long)m_Level);
        
    }
    else
    {
        NSLog(@"Load Data plist info fail !!");
    }
    
    [self ReportScore];
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
    //NSLog(@"Writemute");
    
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


@end
