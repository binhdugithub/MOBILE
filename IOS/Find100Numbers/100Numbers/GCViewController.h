//
//  GCViewController.h
//  Find 100 Numbers
//
//  Created by Nguyễn Thế Bình on 10/9/15.
//  Copyright © 2015 LapTrinhAlgo.Com. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface GCViewController : UIViewController<GKGameCenterControllerDelegate>
{
 
    NSString *m_LeaderboardIdentifier;
    
}

+(instancetype) GetSingleton;
-(void)AuthenticateLocalPlayer;
-(void)ReportScore : (NSInteger) m_BestScore;
- (GKGameCenterViewController*)GetGCView;
- (NSString*) GetLeaderboardIdentifier;
@end
