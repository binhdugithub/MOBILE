//
//  Configuration.h
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 7/18/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Configuration : NSObject
{
    BOOL m_IsMute;
    NSInteger m_BestScore;
    NSInteger m_Score;
    NSInteger m_TimePlay;
    
    NSString *m_LeaderboardIdentifier;
}

+(instancetype) GetSingleton;
-(void)ReportScore;
- (void) SetLeaderboardIdentifier : (NSString*) p_leaderboard;
- (NSInteger) GetBestScore;
- (void) WriteBestScore : (NSInteger) p_socre;
- (NSInteger) GetScore;
- (void) WriteScore : (NSInteger) p_socre;
- (NSInteger) GetTimePlay;
- (void) WriteNextTimePlay;
- (UIImage*) TakeScreenshot;

- (void) WriteMute : (BOOL) p_ismute;
- (BOOL) GetIsMute;
@end
