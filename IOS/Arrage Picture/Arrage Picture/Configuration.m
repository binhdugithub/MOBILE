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
        score.value = m_Score;
        
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
    NSLog(@"data.plist: %@", pathData);
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
       
        m_IsMute = [dicData[@"IsMute"] boolValue];
        m_Level = [dicData[@"Level"] integerValue];
        m_TimePlay = [dicData[@"TimePlay"] integerValue];
        m_Score = [dicData[@"Score"] integerValue];
        if (m_Score == 0) {
            m_Score = MAXFLOAT;
        }

        NSLog(@"Level: %li and TimePlay: %li and Score: %li", m_Level, m_TimePlay, m_Score);
    }
    else
    {
        NSLog(@"Load data.plist fail !!");
        m_IsMute = FALSE;
        m_Level = 0;
        m_TimePlay = 0;
        m_Score = MAXFLOAT;
    }
}


- (BOOL) GetIsMute
{
    return m_IsMute;
}


- (NSInteger) GetLevel
{
    return m_Level;
}

- (void) WriteLevel:(NSInteger)p_level
{
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        
        [dicData setObject:[NSNumber numberWithInteger:p_level] forKey:@"Level"];
        [dicData writeToFile:pathData atomically:YES];
        m_Level = p_level;
        
        //NSLog(@"Score new: %li", (long)m_Score);
        
    }
    else
    {
        NSLog(@"Load data plist info fail !!");
    }
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



- (UIImage*) TakeScreenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //NSData *imageDataForEmail = UIImageJPEGRepresentation(imageForEmail, 1.0);
    
    return screenImage;
    
}


- (NSInteger) GetTimePlay
{
    return m_TimePlay;
}


- (void) WriteNextTimePlay
{
    m_TimePlay ++;
    m_TimePlay = m_TimePlay >= 10000 ? 0 : m_TimePlay;
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        NSLog(@"Write timeplay: %li", m_TimePlay);
        [dicData setObject:[NSNumber numberWithInteger:m_TimePlay] forKey:@"TimePlay"];
        [dicData writeToFile:pathData atomically:YES];
    }
    else
    {
        NSLog(@"Load data plist info fail !!");
    }
}


- (NSInteger) GetScore
{
    return m_Score;
}

- (void) WriteScore : (NSInteger) p_score
{
    m_Score = m_Score > p_score ? p_score : m_Score;
    NSString *pathData = [self GetPathData];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        NSLog(@"Write score: %li", m_Score);
        [dicData setObject:[NSNumber numberWithInteger:m_Score] forKey:@"Score"];
        [dicData writeToFile:pathData atomically:YES];
        
        [self ReportScore];
    }
    else
    {
        NSLog(@"Load data plist info fail !!");
    }
}

@end
