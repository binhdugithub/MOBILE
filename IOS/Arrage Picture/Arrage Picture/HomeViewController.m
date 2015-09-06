//
//  ViewController.m
//  DoDanGian
//
//  Created by Binh Du  on 4/20/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import "HomeViewController.h"
#import "Define.h"


@interface HomeViewController ()


@property (weak, nonatomic) IBOutlet UIView *m_ViewHeader;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnSpeaker;
@property (weak, nonatomic) IBOutlet UILabel *m_LblLevel;
@property (weak, nonatomic) IBOutlet UILabel *m_LblTitle;

@property (weak, nonatomic) IBOutlet UIButton *m_BtnPlay;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnGameCenter;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnRate;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnReset;

@end

@implementation HomeViewController
@synthesize m_ViewHeader, m_LblLevel, m_BtnSpeaker;
@synthesize m_BtnGameCenter, m_BtnPlay, m_BtnRate;
@synthesize m_BtnReset;
@synthesize m_LblTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self AuthenticateLocalPlayer];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self InitGUI];
    [[SoundController GetSingleton] ShowSpeaker:m_BtnSpeaker];
    
    
}

- (void) InitGUI
{
    
    NSLog(@"This device is width: %f and height: %f", SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.view.backgroundColor = [UIColor colorWithRed:85.0/255 green:137.0/255 blue:125.0/255 alpha:1];
    
    //
    //Header
    //
    CGRect frm;
    frm.size.width = SCREEN_WIDTH;
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.height = 40;
    }
    else if(IS_IPAD)
    {
        frm.size.height = 60;
    }
    else
    {
        frm.size.height = 50;
    }
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_ViewHeader.frame = frm;
    m_ViewHeader.backgroundColor = [UIColor colorWithRed:66.0/255 green:84.0/255 blue:84.0/255 alpha:1];
 
    //m_LblLevel
    frm.size.width = 1.0/2 * SCREEN_WIDTH;
    frm.size.height = m_ViewHeader.frame.size.height;
    frm.origin.x = 1.0/2 * (m_ViewHeader.frame.size.width - frm.size.width);
    frm.origin.y = 1.0/2 * (m_ViewHeader.frame.size.height - frm.size.height);
    m_LblLevel.frame = frm;
    
    if(IS_IPAD)
    {
        [m_LblLevel setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        [m_LblLevel setFont:[UIFont systemFontOfSize:16 weight:0.5]];
    }
    else
    {
        [m_LblLevel setFont:[UIFont systemFontOfSize:18 weight:0.5]];
    }
    
    [m_LblLevel setTextColor:[UIColor whiteColor]];
    [m_LblLevel setTextAlignment:NSTextAlignmentCenter];
    NSString *l_level_string = [NSString stringWithFormat:@"LEVEL: %li", [[Configuration GetSingleton] GetLevel]];
    m_LblLevel.text = l_level_string;
    
    //speaker
    frm.size.width = 1.0/2 * (m_ViewHeader.frame.size.height);
    frm.size.height = frm.size.width;
    frm.origin.y = 1.0/2 * (m_ViewHeader.frame.size.height - frm.size.height);
    frm.origin.x = m_ViewHeader.frame.size.width - frm.size.width - 1.0/2 * frm.size.width;
    m_BtnSpeaker.frame = frm;
    
    //subhdear
    frm = m_ViewHeader.frame;
    frm.size.height = 2;
    frm.origin.y = m_ViewHeader.frame.origin.y + m_ViewHeader.frame.size.height;
    UIView *l_subHeader = [[UIView alloc] initWithFrame:frm];
    [self.view addSubview:l_subHeader];
    l_subHeader.backgroundColor = [UIColor colorWithRed:123.0/255 green:86.0/255 blue:79.0/255 alpha:1];
    
    //
    //end header
    //
    
    
    //title
    frm.size.width =  SCREEN_WIDTH;
    frm.size.height = m_ViewHeader.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = -50;
    m_LblTitle.frame = frm;
    if (IS_IPAD)
    {
        [m_LblTitle setFont:[UIFont systemFontOfSize:35 weight:1]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        [m_LblTitle setFont:[UIFont systemFontOfSize:20 weight:1]];
    }
    else
    {
        [m_LblTitle setFont:[UIFont systemFontOfSize:25 weight:1]];
    }
    
    
    [m_LblTitle setTextColor:[UIColor whiteColor]];
    [m_LblTitle setTextAlignment:NSTextAlignmentCenter];
    [m_LblTitle setText:@"Match Picture Puzzle"];
    
    //Play
    frm.size.width = SCREEN_WIDTH * 1.0/2;
    frm.size.height = 1.0/2 * frm.size.width;
    frm.origin.x = 1.0/2 * (SCREEN_WIDTH - frm.size.width);
    frm.origin.y = 1.0/2 *(SCREEN_HEIGHT - frm.size.height) - 1.0/2 * frm.size.height;
    m_BtnPlay.frame = frm;
    
    //RESET
    frm.size.width = SCREEN_WIDTH * 1.0/2;
    frm.size.height = 1.0/2 * frm.size.width;
    frm.origin.x = 1.0/2 * (SCREEN_WIDTH - frm.size.width);
    frm.origin.y = m_BtnPlay.frame.origin.y + m_BtnPlay.frame.size.height + 10;
    //[m_BtnReset setBackgroundImage:[UIImage imageNamed:@"btn_reset.png"] forState:UIControlStateNormal];
    m_BtnReset.frame = frm;
    
    //game center
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.width = 40;
    }
    else if(IS_IPAD)
    {
        frm.size.width = 60;
    }
    else
    {
        frm.size.width = 50;
    }
    
    frm.size.height = frm.size.width;
    frm.origin.x = m_BtnReset.frame.origin.x;
    frm.origin.y = m_BtnReset.frame.origin.y + m_BtnReset.frame.size.height + 10;
    
    m_BtnGameCenter.frame = frm;
    //[m_BtnGameCenter setBackgroundImage:[UIImage imageNamed:@"btn_gamecenter.png"] forState:UIControlStateNormal];
    
    //game rate
    frm = m_BtnGameCenter.frame;
    frm.origin.x = (m_BtnPlay.frame.origin.x + m_BtnPlay.frame.size.width - frm.size.width);
    m_BtnRate.frame = frm;
    //[m_BtnRate setBackgroundImage:[UIImage imageNamed:@"btn_rate.png"] forState:UIControlStateNormal];
    
    
   //footer
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = m_ViewHeader.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = SCREEN_HEIGHT - frm.size.height;
    UIView *l_ViewFooter = [[UIView alloc ] initWithFrame:frm];
    l_ViewFooter.backgroundColor = [UIColor colorWithRed:66.0/255 green:84.0/255 blue:84.0/255 alpha:1];
    
    int l_w = 50;
    if (IS_IPAD) {
        l_w = 70;
    }
    int l_number = SCREEN_WIDTH / l_w;
    CGFloat l_space = (SCREEN_WIDTH - l_number * l_w) / (l_number + 1);
    NSLog(@"Number image: %i", l_number);
    
    for (int i = 0; i < l_number; i++)
    {
        CGRect frm;
        frm.size.width = l_w;
        frm.size.height = frm.size.width;
        frm.origin.x = l_space + i * (l_space + l_w);
        frm.origin.y = 0;
        UIImageView *l_temp = [[UIImageView alloc]initWithFrame:frm];
        [l_ViewFooter addSubview:l_temp];
        
        NSString *l_nameImage = [NSString stringWithFormat:@"%li.jpg", (long)(i+1)];
        UIImage *l_img = [UIImage imageNamed:l_nameImage];
        [l_temp setImage:l_img];
    }
    
    
    [self.view addSubview:l_ViewFooter];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    frm = m_LblTitle.frame;
    frm.origin.y = l_subHeader.frame.origin.y + 1.0/2 *(m_BtnPlay.frame.origin.y - l_subHeader.frame.origin.y - l_subHeader.frame.size.height - frm.size.height);
   
    m_LblTitle.frame = frm;
    [UIView commitAnimations];
    
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
    
    //[[GADMasterViewController GetSingleton] GetInterstitialAds];
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


- (IBAction)ResetClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    NSString *msg = [NSString stringWithFormat:@"You will start again from the first level ?"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:msg delegate:self  cancelButtonTitle:@"CANCEL"  otherButtonTitles:@"OK" ,nil];
    alert.tag = 100;
    [alert show];
    
    
}


- (IBAction)SpeakerClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [[SoundController GetSingleton] ShowSpeaker:m_BtnSpeaker];

    //[self ShowSpeaker];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 100 && buttonIndex == 1)
    {
        [[Configuration GetSingleton] WriteLevel:1];
        NSString *l_level_string = [NSString stringWithFormat:@"LEVEL: %li", [[Configuration GetSingleton] GetLevel]];
        m_LblLevel.text = l_level_string;
    }
}
- (IBAction)PlayClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}


@end
