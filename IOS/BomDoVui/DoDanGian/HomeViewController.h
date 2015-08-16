//
//  ViewController.h
//  DoDanGian
//
//  Created by Binh Du  on 4/20/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface HomeViewController : UIViewController<GKGameCenterControllerDelegate>
{
    bool m_GameCenterEnabled;
    NSString *m_LeaderboardIdentifier;
}


@end

