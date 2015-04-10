//
//  ViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

@import GoogleMobileAds;


#import "HomeViewController.h"
#import "SoundController.h"
#import "SinglePlayerViewController.h"



@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButton1Player;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButton2Players;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonAbout;

@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UIlabelCopyright;
@property (weak, nonatomic) IBOutlet UIImageView *m_UIImageViewBackGround;

@end

@implementation HomeViewController
@synthesize m_UIButtonSpeaker, m_UIButtonAbout;
@synthesize m_UIButton1Player,m_UIButton2Players;
@synthesize m_UIlabelCopyright, m_UIViewFooter;
@synthesize m_UIImageViewBackGround;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [self ShowSpeaker];
    
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    CGFloat x = 1.0/8 * W;
    CGFloat y = 1.0/3 * H;
    
   // printf("\nW: %f H: %f", W, H);
    //1 bacground
    CGRect frm = m_UIImageViewBackGround.frame;
    frm.size.width = W;
    frm.size.height = H;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIImageViewBackGround.frame = frm;
    
    //2 Player
    frm = m_UIButton2Players.frame;
    frm.size.width = 3.0/4 * W;
    frm.size.height = 1.0/7 * H;
    frm.origin.x = x;
    frm.origin.y = y;
    m_UIButton2Players.frame = frm;
    
    
    //1 Player
    CGRect frm2 = m_UIButton2Players.frame;
    frm2.origin.y = frm2.origin.y - 1.0/4 * frm2.size.height - frm2.size.height;
    m_UIButton1Player.frame = frm2;
    
    //Footer
    frm = m_UIViewFooter.frame;
    frm.size.width = W;
    frm.size.height = 1.0/8 * H;
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    m_UIViewFooter.frame = frm;
    
    //Copyrith
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIlabelCopyright.frame = frm;
    
    // About
    frm = m_UIButtonAbout.frame;
    frm.size.width = 1.0/9 * W;
    frm.size.height = frm.size.width;
    frm.origin.x = m_UIButton2Players.frame.origin.x;
    frm.origin.y = m_UIViewFooter.frame.origin.y  - 2 * frm.size.height;
    m_UIButtonAbout.frame =frm;
    
    //Speaker
    frm.origin.x = m_UIButton2Players.frame.origin.x + m_UIButton2Players.frame.size.width - frm.size.width;
    m_UIButtonSpeaker.frame = frm;
    
    
    
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
        NSLog(@"Mute");
        [m_UIButtonSpeaker setImage:[UIImage imageNamed:@"btn_mute.png"] forState: UIControlStateNormal];
    }
    else
    {
        NSLog(@"UnMute");
        [m_UIButtonSpeaker setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SpeakerClick:(id)sender
{
   [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [self ShowSpeaker];
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
