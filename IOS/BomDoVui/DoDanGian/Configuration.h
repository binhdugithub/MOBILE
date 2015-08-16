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
    NSInteger m_Level;
    NSInteger m_Score;
    
    NSString *m_LeaderboardIdentifier;
}

+(instancetype) GetSingleton;
-(void)ReportScore;
- (void) SetLeaderboardIdentifier : (NSString*) p_leaderboard;
- (NSInteger) GetScore;
- (void) WriteScore : (NSInteger) p_socre;
- (NSInteger) GetLevel;
- (void) WriteLevel : (NSInteger) p_level;

- (void) WriteMute : (BOOL) p_ismute;
- (BOOL) GetIsMute;
@end
