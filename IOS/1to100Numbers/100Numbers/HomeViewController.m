//
//  ViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//
#import "HomeViewController.h"

@interface HomeViewController ()


@property (weak, nonatomic) IBOutlet UILabel *m_UILabel100;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButton1Player;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButton2Players;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonAbout;

@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UIlabelCopyright;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonGameCenter;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonRate;


@property (strong, nonatomic) UIButton *m_FBButton;
@property (strong, nonatomic) UIButton *m_TWButton;

@end

@implementation HomeViewController

@synthesize m_UIButtonSpeaker, m_UIButtonAbout;
@synthesize m_UIButton1Player,m_UIButton2Players;
@synthesize m_UIlabelCopyright, m_UIViewFooter, m_UIViewHeader;
@synthesize m_UILabel100;
@synthesize m_UIButtonGameCenter, m_UIButtonRate;
@synthesize m_FBButton, m_TWButton;



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [self ShowSpeaker];
    [[GCViewController GetSingleton] AuthenticateLocalPlayer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self ShowSocialButton];
    
}

-(void)CalculateView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:0/255.0 green:66/255.0 blue:66/255.0 alpha:1]];

    // header
    CGRect frm_header;
    frm_header.size.width = SCREEN_WIDTH;
    if(SCREEN_HEIGHT <= 400)
    {
       frm_header.size.height = 32;
    }
    else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720)
    {
        frm_header.size.height = 50;
    }else if(SCREEN_HEIGHT > 720)
    {
        frm_header.size.height = 90;
    }
    
    frm_header.origin.x = 0;
    frm_header.origin.y = 0;
    m_UIViewHeader.frame = frm_header;
    [m_UIViewHeader setBackgroundColor:[UIColor clearColor]];
    
    //2 Player
    CGRect frm = m_UIButton2Players.frame;
    frm.size.height = H_BTNPLAY * SCREEN_HEIGHT;
    frm.size.width = 2 * frm.size.height;
    
    frm.origin.x = (SCREEN_WIDTH - frm.size.width ) /2.0;
    frm.origin.y = 1.0/2 * (SCREEN_HEIGHT - frm.size.height);
    m_UIButton2Players.frame = frm;
    m_UIButton2Players.layer.cornerRadius = 10;
   
    [m_UIButton2Players setBackgroundColor:[UIColor clearColor]];
    [m_UIButton2Players setBackgroundImage:[UIImage imageNamed:@"btn_play2.png"] forState:UIControlStateNormal];
    [m_UIButton2Players setBackgroundImage:[UIImage imageNamed:@"btn_play2_pressed.png"] forState:UIControlStateHighlighted];
    
    //1 Player
    CGRect frm2 = m_UIButton2Players.frame;
    frm2.origin.y = frm2.origin.y - 1.0/4 * frm2.size.height - frm2.size.height;
    m_UIButton1Player.frame = frm2;
    m_UIButton1Player.layer.cornerRadius = 10;
   
    [m_UIButton1Player setBackgroundColor:[UIColor clearColor]];
    [m_UIButton1Player setBackgroundImage:[UIImage imageNamed:@"btn_play1.png"] forState:UIControlStateNormal];
    [m_UIButton1Player setBackgroundImage:[UIImage imageNamed:@"btn_play1_pressed.png"] forState:UIControlStateHighlighted];
    
    //100
    frm = m_UIButton1Player.frame;
    frm.origin.y = frm.origin.y - frm.size.height;
    m_UILabel100.frame = frm;
    m_UILabel100.hidden = TRUE;
    
    //Footer
    frm = m_UIViewFooter.frame;
    frm.size.width = SCREEN_WIDTH;
    if(SCREEN_HEIGHT <= 400){frm.size.height = 32;}else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720){frm.size.height = 50;}else if(SCREEN_HEIGHT > 720){frm.size.height = 90;};
    
    frm.origin.x = 0;
    frm.origin.y = SCREEN_HEIGHT - frm.size.height;
    m_UIViewFooter.frame = frm;
    m_UIViewFooter.backgroundColor = [UIColor clearColor];
    
    //Copyrith
    frm = m_UIViewFooter.frame;
    frm.origin.x = 0;
    frm.origin.y =  0;
    m_UIlabelCopyright.frame = frm;
    [m_UIlabelCopyright setTextColor:[UIColor darkGrayColor]];
    [m_UIlabelCopyright setText:TEXT_COPYRIGHT];
    if (IS_IPHONE_4_OR_LESS)
    {
        [m_UIlabelCopyright setFont:[UIFont systemFontOfSize:10 weight:0.5]];
    }
    else if (IS_IPAD)
    {
        [m_UIlabelCopyright setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    }
    else
    {
        [m_UIlabelCopyright setFont:[UIFont systemFontOfSize:15 weight:0.5]];
    }

    
    // About
    frm = m_UIButtonAbout.frame;
    frm.size.width = W_ICON* SCREEN_WIDTH;
    frm.size.height = frm.size.width;
    frm.origin.x = m_UIButton2Players.frame.origin.x;
    frm.origin.y = m_UIViewFooter.frame.origin.y  - 2 * frm.size.height;
    m_UIButtonAbout.frame =frm;
    m_UIButtonAbout.hidden = TRUE;
    
    //Speaker
    frm.origin.x = m_UIButton2Players.frame.origin.x + m_UIButton2Players.frame.size.width - frm.size.width;
    m_UIButtonSpeaker.frame = frm;
    m_UIButtonSpeaker.hidden = TRUE;
    
    //game center
    //m_UIButtonGameCenter.hidden = TRUE;
    CGRect frm_gamecenter = m_UIButton2Players.frame;
    frm_gamecenter.size.width = 9.0/20 * m_UIButton2Players.frame.size.width;
    frm_gamecenter.size.height = 1.0/2 * m_UIButton2Players.frame.size.height;
    frm_gamecenter.origin.y = m_UIViewFooter.frame.origin.y - frm_gamecenter.size.height;
    m_UIButtonGameCenter.frame = frm_gamecenter;
    m_UIButtonGameCenter.layer.cornerRadius = 5;
    //[m_UIButtonGameCenter setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:104.0/255.0 blue:175.0/255.0 alpha:1]];
    
    [m_UIButtonGameCenter setBackgroundColor:[UIColor clearColor]];
    [m_UIButtonGameCenter setBackgroundImage:[UIImage imageNamed:@"btn_gamecenter.png"] forState:UIControlStateNormal];
    [m_UIButtonGameCenter setBackgroundImage:[UIImage imageNamed:@"btn_gamecenter_pressed.png"] forState:UIControlStateHighlighted];
    
    //rate
    CGRect frm_rate = m_UIButtonGameCenter.frame;
    frm_rate.origin.x = m_UIButtonGameCenter.frame.origin.x + m_UIButtonGameCenter.frame.size.width + 2.0/20 * m_UIButton2Players.frame.size.width;
    m_UIButtonRate.frame = frm_rate;
    m_UIButtonRate.layer.cornerRadius = 5;
    [m_UIButtonRate setBackgroundColor:[UIColor clearColor]];
    [m_UIButtonRate setBackgroundImage:[UIImage imageNamed:@"btn_rate.png"] forState:UIControlStateNormal];
    [m_UIButtonRate setBackgroundImage:[UIImage imageNamed:@"btn_rate_pressed.png"] forState:UIControlStateHighlighted];
    
   
    
    //facebook
    CGRect l_frame = CGRectMake(0, 0, 0, 0);
    l_frame.size.height =  3.0/4 * m_UIButtonRate.frame.size.height;
    l_frame.size.width = 3.0 * l_frame.size.height;
    l_frame.origin.x = self.view.frame.size.width;
    l_frame.origin.y = m_UIButtonRate.frame.origin.y - 2 * l_frame.size.height - 2.0/5 * l_frame.size.height;
    
    m_FBButton = [[UIButton alloc] initWithFrame:l_frame];
    m_FBButton.backgroundColor = [UIColor clearColor];
    
//    UIGraphicsBeginImageContext(m_FBButton.frame.size);
//    [[UIImage imageNamed:@"fb"] drawInRect:m_FBButton.bounds];
//    UIImage *l_img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [m_FBButton setImage:[UIImage imageNamed:@"fb"] forState:UIControlStateNormal];
    
//    UIGraphicsBeginImageContext(m_FBButton.frame.size);
//    [[UIImage imageNamed:@"fb_pressed"] drawInRect:m_FBButton.bounds];
//    UIImage *l_img2 = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [m_FBButton setImage:[UIImage imageNamed:@"fb_pressed"] forState:UIControlStateHighlighted];
  
    [m_FBButton setTitle:@"" forState:UIControlStateNormal];
    [m_FBButton addTarget:self action:@selector(FBClick:) forControlEvents:UIControlEventTouchUpInside];
    
     //tw
    l_frame = m_FBButton.frame;
    //l_frame.origin.x = m_UIButtonRate.frame.origin.x + m_UIButtonRate.frame.size.width + 10;
    l_frame.origin.y = m_FBButton.frame.origin.y + m_FBButton.frame.size.height + 1.0/5 * m_FBButton.frame.size.height;
    m_TWButton = [[UIButton alloc] initWithFrame:l_frame];
    m_TWButton.backgroundColor = [UIColor clearColor];
    
//    UIGraphicsBeginImageContext(m_TWButton.frame.size);
//    [[UIImage imageNamed:@"tw"] drawInRect:m_FBButton.bounds];
//    UIImage *l_imgtw = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [m_TWButton setImage:[UIImage imageNamed:@"tw"] forState:UIControlStateNormal];
    
//    UIGraphicsBeginImageContext(m_TWButton.frame.size);
//    [[UIImage imageNamed:@"tw_pressed"] drawInRect:m_FBButton.bounds];
//    UIImage *l_imgtw_pressed = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    [m_TWButton setImage:[UIImage imageNamed:@"tw_pressed"] forState:UIControlStateHighlighted];
    
    [m_TWButton setTitle:@"" forState:UIControlStateNormal];
    [m_TWButton addTarget:self action:@selector(TWClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:m_FBButton];
    [self.view addSubview:m_TWButton];
}

- (void) ShowSocialButton
{
    CGRect l_fb = self.m_FBButton.frame;
    l_fb.origin.x = self.view.frame.size.width - l_fb.size.width + 10;
    
    CGRect l_tw = self.m_TWButton.frame;
    l_tw.origin.x = l_fb.origin.x;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.m_FBButton.frame = l_fb;
    self.m_TWButton.frame = l_tw;
    [UIView commitAnimations];
}

-(void) FBClick: (UIButton*) sender
{

    NSString *l_linkapp = @"https://www.facebook.com/cusikiapp";
    NSURL *l_url = [[NSURL alloc] initWithString:l_linkapp];
    [[UIApplication sharedApplication] openURL:l_url];

}

-(void) TWClick: (UIButton*) sender
{
    
    NSString *l_linkapp = @"https://twitter.com/cusikiapp";
    NSURL *l_url = [[NSURL alloc] initWithString:l_linkapp];
    [[UIApplication sharedApplication] openURL:l_url];
    
}

- (IBAction)SinglePlayerClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [self performSegueWithIdentifier:@"SegueSinglePlayer" sender:self];
}

- (IBAction)TwoPlayersClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

- (IBAction)AboutClick:(id)sender
{
   [[SoundController GetSingleton] PlayClickButton];
}

- (void) ShowSpeaker
{
    
    if ([[SoundController GetSingleton] GetMute])
    {
        //NSLog(@"Mute");
        [m_UIButtonSpeaker setImage:[UIImage imageNamed:@"btn_mute.png"] forState: UIControlStateNormal];
    }
    else
    {
        //NSLog(@"UnMute");
        [m_UIButtonSpeaker setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SpeakerClick:(id)sender
{
   [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [self ShowSpeaker];
}

- (IBAction)GameCenter:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [self presentViewController:[[GCViewController GetSingleton] GetGCView] animated:YES completion:nil];
}


- (IBAction)m_MoreApp:(id)sender
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


- (BOOL) prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SegueSinglePlayer"])
    {
        SinglePlayerViewController *MySinglePlayer = (SinglePlayerViewController *)[segue destinationViewController];
        [MySinglePlayer SetStateGame:FIRSTWIEW];
    }
    
}
@end
