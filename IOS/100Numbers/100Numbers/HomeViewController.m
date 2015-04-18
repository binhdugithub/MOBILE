//
//  ViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//
#import "HomeViewController.h"
#import "SoundController.h"
#import "SinglePlayerViewController.h"
#import "GADMasterViewController.h"
///#import "Define.h"



@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_UILabel100;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButton1Player;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButton2Players;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonAbout;

@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UIlabelCopyright;

@end

@implementation HomeViewController
@synthesize m_UIButtonSpeaker, m_UIButtonAbout;
@synthesize m_UIButton1Player,m_UIButton2Players;
@synthesize m_UIlabelCopyright, m_UIViewFooter;
@synthesize m_UILabel100;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [self ShowSpeaker];

    [[GADMasterViewController singleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
    
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
    
   // printf("\nW: %f H: %f", W, H);
    //1 bacground
    //[self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:238.0/255.0 blue:169.0/255.0 alpha:1]];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];

    
    //2 Player
    CGRect frm = m_UIButton2Players.frame;
    frm.size.width = W_BTNPLAY * W;
    frm.size.height = H_BTNPLAY * H;
    frm.origin.x = (W - frm.size.width ) /2.0;
    frm.origin.y = 1.0/2 * H;
    m_UIButton2Players.frame = frm;
    m_UIButton2Players.layer.cornerRadius = 10;
    [m_UIButton2Players setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:104.0/255.0 blue:175.0/255.0 alpha:1]];
    //m_UIButton2Players.layer.borderColor = [UIColor whiteColor].CGColor;
    //m_UIButton2Players.layer.borderWidth = 2.0f;
    
    
    //1 Player
    CGRect frm2 = m_UIButton2Players.frame;
    frm2.origin.y = frm2.origin.y - 1.0/4 * frm2.size.height - frm2.size.height;
    m_UIButton1Player.frame = frm2;
    m_UIButton1Player.layer.cornerRadius = 10;
    [m_UIButton1Player setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:104.0/255.0 blue:175.0/255.0 alpha:1]];
    //m_UIButton1Player.layer.borderColor = [UIColor whiteColor].CGColor;
    //m_UIButton1Player.layer.borderWidth = 2.0f;
    
    //100
    frm = m_UIButton1Player.frame;
    frm.origin.y = frm.origin.y - frm.size.height;
    m_UILabel100.frame = frm;
    //Footer
    frm = m_UIViewFooter.frame;
    frm.size.width = W;
    frm.size.height = H_FOOTER * H;
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    m_UIViewFooter.frame = frm;
    
    //Copyrith
    frm.size.height =  H_FOOTER * H * 1.0/2;
    frm.origin.x = 0;
    frm.origin.y =  H_FOOTER * H * 1.0/2;
    m_UIlabelCopyright.frame = frm;

    
    // About
    frm = m_UIButtonAbout.frame;
    frm.size.width = W_ICON* W;
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
