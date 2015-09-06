//
//  ViewController.h
//  Arrage Picture
//
//  Created by Nguyễn Thế Bình on 8/24/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface HomeViewController : UIViewController<GKGameCenterControllerDelegate>
{
    bool m_GameCenterEnabled;
    NSString *m_LeaderboardIdentifier;
}


@end

