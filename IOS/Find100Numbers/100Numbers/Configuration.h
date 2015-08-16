//
//  Configuration.h
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 7/18/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject
{
    BOOL m_IsMute;
    NSInteger m_TimesPlayed;
    NSInteger m_BestScore;
    NSInteger m_AverageScore;
    NSString *m_LeaderboardIdentifier;
}

+(instancetype) GetSingleton;
- (void) SetLeaderboardIdentifier : (NSString*) p_leaderboard;
- (void) WriteMute : (BOOL) p_ismute;
- (void) UpdateStatistics : (NSInteger) p_currentscore;
- (void) ClearConfig;
- (NSInteger) GetBestScore;
- (NSInteger) GetTimesPlayed;
- (NSInteger) GetAverageScore;
- (BOOL) GetIsMute;
@end
