//
//  ViewController.h
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface HomeViewController : UIViewController<GKGameCenterControllerDelegate>
{
    bool m_GameCenterEnabled;
    NSString *m_LeaderboardIdentifier;
    
}


@end

