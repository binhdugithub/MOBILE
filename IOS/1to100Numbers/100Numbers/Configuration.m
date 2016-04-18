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
       
    }
    
    return self;
}

- (void) LoadMoreApps: (GameOverViewController*) p_view
{
     NSURL *url = [NSURL URLWithString:@"http://cusiki.com:8888/api/funnystories/apps"];
    // Create a download task.
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData *data,
                                                                                 NSURLResponse *response,
                                                                                 NSError *error)
                                  {
                                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                                         
                                          if (!error)
                                          {
                                              NSError *JSONError = nil;
                                              NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                         options:0
                                                                                                           error:&JSONError];
                                              if (JSONError)
                                              {
                                                  NSLog(@"Serialization error: %@", JSONError.localizedDescription);
                                                  
                                              }
                                              else
                                              {
                                                  m_more_apps = [[NSMutableArray alloc] init];
                                                  NSArray *l_arry = dictionary[@"apps"];
                                                  for (int i = 0; i < l_arry.count; i++)
                                                  {
                                                      NSMutableDictionary *l_dict = [[NSMutableDictionary alloc] initWithDictionary:l_arry[i] copyItems:true];
                                                      //[l_dict setObject: nil  forKey:@"imgdata"];
                                                      [m_more_apps addObject:l_dict];
                                                  }
                                                  
                                                  //m_more_apps = [[NSMutableArray alloc] initWithArray:l_arry copyItems:true];
                                                  //m_more_apps = dictionary[@"apps"];
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [p_view SetupMoreAppView];
                                                  });
                                              }
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                          
                                         
                                      });
                                      
                                      
                                  }];
    // Start the task.
    [task resume];
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