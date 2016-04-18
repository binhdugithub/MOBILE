
//
//  1PlayerViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "SinglePlayerViewController.h"
#import "GameOverViewController.h"
#import  "StatisticsViewController.h"
#import "GADMasterViewController.h"
#import "Configuration.h"
#include "SoundController.h"
#import "Define.h"


@interface SinglePlayerViewController ()
{
    NSMutableArray *m_Array100Number;
    NSInteger m_CurrentNumber;
    NSInteger  m_Sate;
    NSTimer *m_Timer;
    NSInteger  m_currentTime;
}

@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UIView *m_UIView100Number;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonPlay;
@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UIlabelCopyright;

@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonStatistics;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTime;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonHome;

@end

@implementation SinglePlayerViewController
@synthesize m_UIButtonPlay, m_UIView100Number, m_UIViewFooter,m_UIlabelCopyright, m_UIViewHeader;
@synthesize m_UIButtonSpeaker, m_UIButtonStatistics, m_UIButtonHome;
@synthesize m_UILabelTime;



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"*******************SinglePlayerViewController*******************");
    [self.view setBackgroundColor:[UIColor colorWithRed:0/255.0 green:66/255.0 blue:66/255.0 alpha:0.9]];
    
    [self CalculateView];
    [self ShowSpeaker];
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
    [self HideTimeDurration];
    
    switch (m_Sate)
    {
        case FIRSTWIEW:
            [self InitFirstView];
            break;
        case BACKVIEW:
            [self InitBackView];
            break;
        default:
            break;
    }
    
    
}


-(void)CalculateView
{
    
    //Header
    //
    
    //Home
    CGRect frm;
    frm.size.width = W_ICON * SCREEN_WIDTH;
    
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.width -= 5;
    }else if(IS_IPAD)
    {
        frm.size.width -= 15;
    }
    
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/2 * frm.size.width;
    frm.origin.y = 1.0/4 * frm.size.height;
    m_UIButtonHome.frame =frm;
    
    //header
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = 3.0/2 * m_UIButtonHome.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIViewHeader.frame = frm;
    
    //Speaker
    frm = m_UIButtonHome.frame;
    frm.origin.x = m_UIViewHeader.frame.size.width - frm.size.width - 1.0/2 * frm.size.width;
    m_UIButtonSpeaker.frame = frm;
    
    //statistics
    frm.origin.x = 1.0/2 * (m_UIViewHeader.frame.size.width - frm.size.width);
    m_UIButtonStatistics.frame = frm;
    
    
    //Time
    frm = m_UIViewHeader.frame;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTime.frame = frm;
    if (IS_IPHONE_4_OR_LESS)
    {
        [m_UILabelTime setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    }
    else if (IS_IPAD)
    {
        [m_UILabelTime setFont:[UIFont systemFontOfSize:30 weight:0.5]];
    }
    else
    {
        [m_UILabelTime setFont:[UIFont systemFontOfSize:25 weight:0.5]];
    }
   
    
    //100Numbers
    frm = m_UIView100Number.frame;
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = frm.size.width;
    frm.origin.x = 0;
    frm.origin.y = m_UIViewHeader.frame.size.height;
    m_UIView100Number.frame = frm;
    [m_UIView100Number setBackgroundColor:[UIColor clearColor]];
    
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

    
    //Play
    frm = m_UIButtonPlay.frame;
    frm.size.width = 4.0/5 * SCREEN_WIDTH;
    frm.size.height = 2.0/3 * (m_UIViewFooter.frame.origin.y - m_UIView100Number.frame.origin.y - m_UIView100Number.frame.size.height);
    frm.origin.x = (SCREEN_WIDTH - frm.size.width ) * 1.0/2;
    frm.origin.y = m_UIView100Number.frame.origin.y + m_UIView100Number.frame.size.height + frm.size.height * 1.0/4;
    m_UIButtonPlay.frame = frm;
    m_UIButtonPlay.layer.cornerRadius = 10;
    
    if (IS_IPHONE_4_OR_LESS)
    {
        m_UIButtonPlay.titleLabel.font = [UIFont systemFontOfSize:13 weight:0.5];
    }
    else if(IS_IPAD_1X || IS_IPAD_2X)
    {
        m_UIButtonPlay.titleLabel.font = [UIFont systemFontOfSize:21 weight:0.5];
    }
    else if (IS_IPAD_PRO)
    {
        m_UIButtonPlay.titleLabel.font = [UIFont systemFontOfSize: 24 weight: 0.5];
    }
    else
    {
        m_UIButtonPlay.titleLabel.font = [UIFont systemFontOfSize:17 weight:1];
    }
    
    [m_UIButtonPlay setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    //[m_UIButtonPlay setTitleColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonPlay setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonPlay setTitle:[NSString stringWithFormat:@"REPLAY"] forState:UIControlStateNormal];
    
}


- (void)SetStateGame: (NSInteger) p_state
{
    m_Sate = p_state;
}

- (void)SetArrayNumber: (NSMutableArray*) p_array
{
    CGRect frm = m_UIView100Number.frame;
    frm.origin.x = 0;
    frm.size.width = [UIScreen mainScreen].bounds.size.width;
    frm.size.height = [UIScreen mainScreen].bounds.size.width;
    
    m_UIView100Number.frame = frm;
    
    m_Array100Number = [[NSMutableArray alloc] init];
    for (UIButton *l_number in p_array)
    {
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:l_number.frame];
        MyNumber.tag = l_number.tag;
        MyNumber.titleLabel.font = l_number.titleLabel.font;
        
        [MyNumber setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%li", (long)(MyNumber.tag) ] forState:UIControlStateNormal];
        [MyNumber setBackgroundColor:l_number.backgroundColor];
        MyNumber.layer.cornerRadius = l_number.layer.cornerRadius;
        MyNumber.alpha = l_number.alpha;
        
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [m_UIView100Number addSubview:MyNumber];
        [m_Array100Number addObject:MyNumber];
    }
}


- (void)InitBackView
{
    for (UIButton *MyNumber in m_Array100Number)
    {
        [m_UIView100Number addSubview:MyNumber];
    }
    
}


- (void)InitFirstView
{
    m_Array100Number = [[NSMutableArray alloc] init];
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/20 + 10);
    CGFloat h = w;
    
    CGRect frm = m_UIView100Number.frame;
    frm.origin.x = 0;
    frm.size.width = [UIScreen mainScreen].bounds.size.width;
    frm.size.height = [UIScreen mainScreen].bounds.size.width;
    m_UIView100Number.frame = frm;
    
    for (NSUInteger i=0; i < 100; i++)
    {
        CGFloat x = (i % 10) * (1.0/ 20 + 1) * w;
        CGFloat y = (i / 10) * (1.0/20 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        MyNumber.frame = CGRectMake(x, y, w, h);
        MyNumber.tag = i + 1;
        
        
        int l_size = 0;
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
        {
            l_size = 11;
        }
        else if (IS_IPHONE_6)
        {
            l_size = 13;
        }
        else if (IS_IPHONE_6P)
        {
            l_size = 15;
        }
        else if(IS_IPAD_1X || IS_IPAD_2X)
        {
            l_size = 19;
        }
        else if (IS_IPAD_PRO)
        {
            l_size = 24;
        }
        else
        {
            l_size = 26;
        }
        
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:l_size weight:1];
        
        [MyNumber setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%li", (long)(MyNumber.tag) ] forState:UIControlStateNormal];
       
        
        [MyNumber setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]];
        MyNumber.layer.cornerRadius = 5;
        
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [m_UIView100Number addSubview:MyNumber];
        [m_Array100Number addObject:MyNumber];
    }
}

- (void)ReArange100Number
{
    for (NSUInteger i = m_Array100Number.count-1; i > 0; i--)
    {
        NSUInteger l_temp = arc4random_uniform(i+1);
        [m_Array100Number exchangeObjectAtIndex:i withObjectAtIndex:l_temp];
         
    }
    
    NSInteger i = 0;
    for (UIButton *MyNumber in m_Array100Number)
    {
        CGRect frm = MyNumber.frame;
        CGFloat x = (i % 10) * (1.0/ 20 + 1) * frm.size.width;
        CGFloat y = (i / 10) * (1.0/20 + 1) * frm.size.height;
        
        frm.origin.x = x;
        frm.origin.y = y;
        MyNumber.frame = frm;
        
        [MyNumber setBackgroundColor:[UIColor whiteColor]];
        //[MyNumber setBackgroundImage:nil forState:UIControlStateNormal];
        MyNumber.alpha = 1;
        
        i++;
    }
}

- (void)ShowTimeDurration
{
    //m_UILabelTime.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f);
    m_currentTime = TIME_MAX - 1;
    NSInteger l_m = m_currentTime / 60;
    NSInteger l_s = (m_currentTime % 60);
    m_UILabelTime.text = [NSString stringWithFormat:@"%2li:%2li", (long)l_m, (long)l_s];
    m_UIButtonSpeaker.hidden = TRUE;
    m_UIButtonStatistics.hidden = TRUE;
    m_UIButtonHome.hidden = TRUE;
    m_UILabelTime.hidden = FALSE;
}

- (void) HideTimeDurration
{
    m_UIButtonSpeaker.hidden = FALSE;
    m_UIButtonStatistics.hidden = FALSE;
    m_UIButtonHome.hidden = FALSE;
    m_UILabelTime.hidden = TRUE;
}

- (void)TimeOut: (NSTimer*)p_timer
{
    m_currentTime -= 1;
    NSInteger l_m = m_currentTime / 60;
    NSInteger l_s = (m_currentTime % 60);
    m_UILabelTime.text = [NSString stringWithFormat:@"%02li:%02li", (long)l_m, (long)l_s];
    if (m_currentTime == 0)
    {
        [self GameOver];
    }
}

- (void)NumberClick: (UIButton*)sender
{
    switch (m_Sate)
    {
        case FIRSTWIEW:
        case BACKVIEW:
            return;
        case PREPAREPLAY:
        {
            //m_UILabelTime.text = [NSString stringWithFormat:@"%i", TIME_MAX];
            [self ShowTimeDurration];
            m_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(TimeOut:)
                                           userInfo:nil
                                            repeats:YES];
            m_Sate = PLAYING;
        }
            break;
        case PLAYING:
            m_Sate = PLAYING;
            break;
        default:
            return;
    }
    
    if (sender.tag == (m_CurrentNumber + 1))
    {
        [[SoundController GetSingleton] PlaySoundCorrect];
        m_CurrentNumber += 1;
        sender.alpha = 0.8;
        //[sender setBackgroundImage:[UIImage imageNamed:@"bg_circle.png"] forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor yellowColor]];
        
        if (m_CurrentNumber == 100)
        {
            [self GameWin];
        }
       
    }
    else if(sender.tag < (m_CurrentNumber + 1))
    {
        return;
    }
    else
    {
        NSLog(@"Press button: %li", (long)sender.tag);
        //[sender setBackgroundColor:[UIColor redColor]];
        sender.alpha = 0.8;
        [self GameOver];
    }
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

- (IBAction)StatisticsClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

- (IBAction)HomeClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

- (IBAction)PlayClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
   
    switch (m_Sate)
    {
        case FIRSTWIEW:
            m_Sate = PREPAREPLAY;
            [self ReArange100Number];
            break;
        case BACKVIEW:
            m_Sate = PREPAREPLAY;
            [self ReArange100Number];
            break;
        case PREPAREPLAY:
            m_Sate = PREPAREPLAY;
            [self ReArange100Number];
            break;
        case PLAYING:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"END GAME" message:@"You are about to QUIT the game!\n\nAre you sure?" delegate:self  cancelButtonTitle:@"NO"  otherButtonTitles:@"YES" ,nil];
            alert.tag = 1000;
            [alert show];
        }
            break;
        default:
            break;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (/*alertView.tag == 1000 && */buttonIndex == 1)
    {
        //code for opening settings app in iOS 8
        [m_Timer invalidate];
        m_Timer = nil;
        
        m_Sate = PREPAREPLAY;
        m_CurrentNumber = 0;
        [self HideTimeDurration];
        [self ReArange100Number];
    }
}

- (void)GameOver
{
    NSLog(@"Keu game over !!)");
    [m_Timer invalidate];
    [[SoundController GetSingleton] PlaySoundGameOver];
    [[Configuration GetSingleton] UpdateStatistics:m_CurrentNumber];
    [self performSegueWithIdentifier:@"SegueSingleResult" sender:self];
}

- (void)GameWin
{
    [m_Timer invalidate];
    [[SoundController GetSingleton] PlaySoundCongratulation];
    [[Configuration GetSingleton] UpdateStatistics:m_CurrentNumber];
    [self performSegueWithIdentifier:@"SegueSingleResult" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([[segue identifier] isEqualToString:@"SegueSingleResult"])
    {
        GameOverViewController *MyView = (GameOverViewController*)[segue destinationViewController];
        [MyView SetArrayNumber:m_Array100Number];
        [MyView SetCurrentNumber:m_CurrentNumber];
    
    }
    
    if ([[segue identifier] isEqualToString:@"Segue2SinglePlayer"])
    {
        StatisticsViewController *MyView = (StatisticsViewController*)[segue destinationViewController];
        [MyView SetArrayNumber:m_Array100Number];
        
    }
    
}
@end
