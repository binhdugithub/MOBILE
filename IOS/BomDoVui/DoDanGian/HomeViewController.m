//
//  ViewController.m
//  DoDanGian
//
//  Created by Binh Du  on 4/20/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import "HomeViewController.h"
#import "SoundController.h"
#import "Define.h"
#import "Configuration.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *m_UIImageLogo;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnPlay;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnRate;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnGameCenter;

@end

@implementation HomeViewController
@synthesize m_UIImageLogo, m_BtnGameCenter, m_BtnPlay, m_BtnRate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self authenticateLocalPlayer];
    [self InitGUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) InitGUI
{
    //NSString *deviceType = [self pla
    
    CGFloat W_SCREEN = [UIScreen mainScreen].bounds.size.width;
    CGFloat H_SCREEN = [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"This device is width: %f and height: %f", W_SCREEN, H_SCREEN);
    
    //1 bacground
    [self.view setBackgroundColor:[UIColor colorWithRed:226/255.0 green:220/255.0 blue:186/255.0 alpha:1]];
    
    //logo
    CGRect frm;
    frm.size.width = W_SCREEN * 2.0/3;
    frm.size.height =frm.size.width;
    frm.origin.x = 1.0/2 * (W_SCREEN - frm.size.width);
    
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.origin.y = 1.0/8 * frm.size.height;
    }
    if(IS_IPAD)
    {
        frm.origin.y = 1.0/15 * frm.size.height;
    }
    else
    {
        frm.origin.y = 1.0/4 * frm.size.height;
    }

    
    m_UIImageLogo.frame =frm;
    
    
    //game center
    frm.size.width = 1.0/5 * W_SCREEN;
    frm.size.height = frm.size.width;
    frm.origin.x = m_UIImageLogo.frame.origin.x;
    
    if(IS_IPHONE_4_OR_LESS || IS_IPAD)
    {
        frm.origin.y = H_SCREEN - frm.size.height - 1.0/2 * frm.size.height;
    }
    else
    {
        frm.origin.y = H_SCREEN - 2 * frm.size.height;
    }
    
    
    
    m_BtnGameCenter.frame = frm;
    
    //game rate
    frm = m_BtnGameCenter.frame;
    frm.origin.x = (m_UIImageLogo.frame.origin.x + m_UIImageLogo.frame.size.width) - frm.size.width;
    m_BtnRate.frame = frm;
    
    //play
    frm.size.width = W_SCREEN * 1.0/3;
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/2 * (W_SCREEN - frm.size.width);
    frm.origin.y = m_BtnRate.frame.origin.y - frm.size.height;
    m_BtnPlay.frame = frm;
    
    
    
}


- (IBAction)RateApp:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
#else
    
    NSString *MyApp =[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", YOUR_APP_ID];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSLog(@"VAo day");
        MyApp = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", YOUR_APP_ID];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MyApp]];
    
    //The link for all your Apps, if you have more than one:
    
    //#define MYCOMPANY_URL_PATH @"http://appstore.com/mycompany"
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: MYCOMPANY_URL_PATH]];
    
#endif
}



-(void)authenticateLocalPlayer
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
                m_GameCenterEnabled = YES;
                
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
                         [[Configuration GetSingleton] SetLeaderboardIdentifier:leaderboardIdentifier];
                         NSLog(@"Authen with: %@", leaderboardIdentifier);
                     }
                 }];
            }
            else
            {
                m_GameCenterEnabled = NO;
                
                NSLog(@"Not yet authenticatelocalplayer");
            }
        }
    };
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)GameCenter:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    
    GKGameCenterViewController *GameCenterController = [[GKGameCenterViewController alloc] init];
    if (GameCenterController != nil)
    {
        GameCenterController.gameCenterDelegate = self;
        //The next three lines are the lines of interest...
        GameCenterController.viewState = GKGameCenterViewControllerStateDefault;
        GameCenterController.leaderboardTimeScope = GKLeaderboardTimeScopeToday;
        GameCenterController.leaderboardCategory = m_LeaderboardIdentifier;
        [self presentViewController:GameCenterController animated:YES completion:nil];
    }
}

@end
