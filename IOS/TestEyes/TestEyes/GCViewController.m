//
//  GCViewController.m
//  Find 100 Numbers
//
//  Created by Nguyễn Thế Bình on 10/9/15.
//  Copyright © 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "GCViewController.h"

@interface GCViewController ()

@end

@implementation GCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}


+(instancetype) GetSingleton
{
    static GCViewController *ShareSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        //NSLog(@"GetSingeton");
        ShareSingleton = [[GCViewController alloc] init];
    });
    
    return ShareSingleton;
};

- (id)init
{
    //NSLog(@"Init");
    self = [super init];
    if(self)
    {
        m_LeaderboardIdentifier = nil;
    }
    
    return self;
}

- (NSString*) GetLeaderboardIdentifier
{
    return m_LeaderboardIdentifier;
}

#pragma GameCenter
-(void)AuthenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error)
    {
        if (viewController != nil)
        {
            [self presentViewController:viewController animated:YES completion:nil];
            NSLog(@"Present view controller to authenticate leaderboar");
        }
        else
        {
            if ([GKLocalPlayer localPlayer].authenticated)
            {
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error)
                 {
                     
                     if (error != nil)
                     {
                         NSLog(@"%@", [error localizedDescription]);
                     }
                     else
                     {
                         m_LeaderboardIdentifier = leaderboardIdentifier;
                         NSLog(@"Authen with: %@", leaderboardIdentifier);
                     }
                 }];
            }
            else
            {
                m_LeaderboardIdentifier = nil;
                 NSLog(@"Not yet authenticatelocalplayer");
            }
        }
    };
}


-(void)ReportScore : (NSInteger) m_BestScore
{
    if(m_LeaderboardIdentifier != nil)
    {
        GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:m_LeaderboardIdentifier];
        score.value = m_BestScore;
        
        [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error)
         {
             if (error != nil)
             {
                 NSLog(@"%@", [error localizedDescription]);
             }
         }];
    }
    else
    {
        NSLog(@"LeaderBoard failed");
    }
}

- (GKGameCenterViewController*)GetGCView
{
    if(m_LeaderboardIdentifier == nil)
        return nil;
    
    GKGameCenterViewController *GameCenterController = [[GKGameCenterViewController alloc] init];
    if (GameCenterController != nil)
    {
        GameCenterController.gameCenterDelegate = self;
        //The next three lines are the lines of interest...
        GameCenterController.viewState = GKGameCenterViewControllerStateDefault;
        GameCenterController.leaderboardTimeScope = GKLeaderboardTimeScopeToday;
        GameCenterController.leaderboardCategory = m_LeaderboardIdentifier;
        //[p_ViewController presentViewController:GameCenterController animated:YES completion:nil];
        
        return GameCenterController;
        //[GameCenterController present]
    }
    else
    {
        return  nil;
    }
        
    
    return nil;
}

- (BOOL) IsReady
{
    if (m_LeaderboardIdentifier != nil) {
        return TRUE;
    }
    
    return FALSE;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
