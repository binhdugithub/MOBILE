//
//  ViewController.h
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/17/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADMasterViewController.h"
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController<GKGameCenterControllerDelegate>
{
    bool m_GameCenterEnabled;
    NSString *m_LeaderboardIdentifier;
}


enum STATEGAME
{
    FIRSTWIEW,
    BACKVIEW,
    PREPAREPLAY,
    PLAYING,
    GAMEOVER
};


- (void)SetStateGame: (NSInteger) p_state;
- (void)SetArrayNumber: (NSMutableArray*) p_array;


@end


