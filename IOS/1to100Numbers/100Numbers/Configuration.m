//
//  Configuration.m
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 7/18/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "Configuration.h"
#import "Define.h"
#import "GCViewController.h"
#import "GameOverViewController.h"

@implementation Configuration



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
        m_more_apps = [[NSMutableArray alloc] init];
        [self LoadMoreApps];
    }
    
    return self;
}

- (void) LoadMoreApps
{


    NSArray *F = [NSArray arrayWithObjects:@"Find 100 Numbers", @"1to100numbers.jpg", @"itms-apps://itunes.apple.com/app/id1048219569", nil];
    NSArray *B = [NSArray arrayWithObjects:@"Bờm Đố Vui", @"bomdovui.jpg", @"itms-apps://itunes.apple.com/app/id1028819809", nil];
    NSArray *T = [NSArray arrayWithObjects:@"Test Eyes", @"testeyes.jpg", @"itms-apps://itunes.apple.com/app/id1031081322", nil];
    NSArray *A = [NSArray arrayWithObjects:@"Animal Puzzle", @"animalpuzzle.png", @"itms-apps://itunes.apple.com/app/id1111859523", nil];
    NSArray *Fun = [NSArray arrayWithObjects:@"Funny Stories", @"funnystories.jpg", @"itms-apps://itunes.apple.com/app/id1070241747", nil];
    NSArray *L = [NSArray arrayWithObjects:@"Lovely Puzzle", @"swipepicture.jpg", @"itms-apps://itunes.apple.com/app/id1034155015", nil];
    
    m_more_apps = [[NSMutableArray alloc] init];
    [m_more_apps addObject:F];[m_more_apps addObject:B];[m_more_apps addObject:T];[m_more_apps addObject:A];[m_more_apps addObject:Fun];[m_more_apps addObject:L];
    
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
        
        //NSLog(@"Report score");
        //[self reportScore];
        [[GCViewController GetSingleton] ReportScore:m_BestScore];
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

- (NSMutableArray*) GetMoreApps
{
    return m_more_apps;
}
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


@end
