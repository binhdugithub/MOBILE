//
//  2PalyersViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "TwoPalyersViewController.h"
#import "SoundController.h"
#import "Configuration.h"
#import "GADMasterViewController.h"

enum
{
    READY0,
    READY1,
    READY2,
    REJECTGAME,
    STOPGAME
    
};

@interface TwoPalyersViewController ()
{
    NSMutableArray *m_Array1to50Number;
    NSMutableArray *m_Array51to100Number;
    NSInteger m_ScorePlayer1;
    NSInteger m_ScorePlayer2;
    NSInteger m_CurrentNumber;
    NSInteger  m_Sate;
    NSTimer *m_Timer;
    
    UIButton *m_TempNumber1;
    UIButton *m_TempNumber2;
}

@property (weak, nonatomic) IBOutlet UIView *m_UIViewGroup1;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker1;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonReady1;
@property (weak, nonatomic) IBOutlet UIView *m_UIView1to50;
@property (weak, nonatomic) IBOutlet UIView *m_UIViewResult1;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelWin1;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelScore1;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonHome1;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonShare;


@property (weak, nonatomic) IBOutlet UIView *m_UIViewGroup2;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker2;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonReady2;
@property (weak, nonatomic) IBOutlet UIView *m_UIView51to100;
@property (weak, nonatomic) IBOutlet UIView *m_UIViewResult2;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonHome2;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelWin2;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelScore2;


@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelCopyright;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelCopyright2;

@property (strong, nonatomic) NSRecursiveLock *m_PlayLock;

@end

@implementation TwoPalyersViewController
@synthesize m_UIButtonSpeaker1, m_UIButtonSpeaker2;
@synthesize m_UIView1to50, m_UIView51to100;
@synthesize m_UIViewResult1, m_UIViewResult2;
@synthesize m_UIButtonReady1, m_UIButtonReady2;
@synthesize m_UIButtonHome2;
@synthesize m_UILabelScore1, m_UILabelScore2,m_UIButtonShare;
@synthesize m_UILabelWin1, m_UILabelWin2;
@synthesize m_UIButtonHome1, m_UIViewFooter, m_UILabelCopyright;
@synthesize m_UIViewGroup1, m_UIViewGroup2;
@synthesize m_UILabelCopyright2;
@synthesize m_PlayLock;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:0/255.0 green:66/255.0 blue:66/255.0 alpha:0.9]];
    [self CalculateView];
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
    [self ShowSpeaker];
    m_Sate = READY0;
    m_CurrentNumber = 1;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CalculateView
{
    //CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/20 + 10);
    CGFloat h = w;
    
    //Advertisement
    CGRect frm;
    frm.size.width = SCREEN_WIDTH;
    if(SCREEN_HEIGHT <= 400)
    {
        frm.size.height = 32;
    }
    else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720)
    {
        frm.size.height = 50;
    }else if(SCREEN_HEIGHT > 720)
    {
        frm.size.height = 90;
    };
    
    frm.origin.x = 0;
    frm.origin.y = 1.0/2*(SCREEN_HEIGHT - frm.size.height);
    m_UIViewFooter.frame = frm;
    
    //coptyright
    frm = m_UIViewFooter.frame;
    frm.size.height = 1.0/2 * frm.size.height;
    frm.origin.y = m_UIViewFooter.frame.size.height - frm.size.height;
    m_UILabelCopyright.frame = frm;
    
    //copyright 2
    frm = m_UILabelCopyright.frame;
    frm.origin.y = 0;
    m_UILabelCopyright2.frame = frm;
    m_UILabelCopyright2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    
    //view 1->50
    frm = m_UIView1to50.frame;
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = 1.0/2 * SCREEN_WIDTH;
    frm.origin.x = 0;
    if(IS_IPHONE_4_OR_LESS || IS_IPAD)
    {
        frm.origin.y = m_UIViewFooter.frame.origin.y + m_UIViewFooter.frame.size.height + 1.0/6 * w;
    }
    else
    {
        frm.origin.y = m_UIViewFooter.frame.origin.y + m_UIViewFooter.frame.size.height + 1.0/2 * w;
    }
    
    m_UIView1to50.frame = frm;
    
    //view 51 -> 100
    frm = m_UIView1to50.frame;
    
    if(IS_IPHONE_4_OR_LESS || IS_IPAD)
    {
        frm.origin.y = m_UIViewFooter.frame.origin.y - frm.size.height - 1.0/6 * w;
    }
    else
    {
        frm.origin.y = m_UIViewFooter.frame.origin.y - frm.size.height - 1.0/2 * w;
    }
    m_UIView51to100.frame = frm;
    
    //
    //Group 1
    //
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = SCREEN_HEIGHT - (m_UIView1to50.frame.origin.y + m_UIView1to50.frame.size.height);
    frm.origin.x = 0;
    frm.origin.y = SCREEN_HEIGHT - frm.size.height;
    m_UIViewGroup1.frame = frm;
    
    //speaker1
    frm.size.width = W_ICON * SCREEN_WIDTH;
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.width -= 5;
    }
    else if(IS_IPAD)
    {
        frm.size.width -= 10;
    }
    
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/2 * frm.size.width;
    frm.origin.y = 1.0/2 *(m_UIViewGroup1.frame.size.height - frm.size.height);
    m_UIButtonSpeaker1.frame = frm;
    
    //home 1
    frm = m_UIButtonSpeaker1.frame;
    frm.origin.x = m_UIViewGroup1.frame.size.width - 1.0/2 * frm.size.width - frm.size.width;
    m_UIButtonHome1.frame = frm;
    
    //ready 1
    frm = m_UIViewGroup1.frame;
    frm.size.width = 1.0/2 * frm.size.width;
    frm.size.height = frm.size.height - 1.0/4 * frm.size.height;
    frm.origin.x = 1.0/4 * m_UIViewGroup1.frame.size.width;
    frm.origin.y = 1.0/8 * m_UIViewGroup1.frame.size.height;
    m_UIButtonReady1.frame = frm;
    m_UIButtonReady1.layer.cornerRadius = 10;
    [m_UIButtonReady1 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    
    if (IS_IPHONE_4_OR_LESS)
    {
        m_UIButtonReady1.titleLabel.font = [UIFont systemFontOfSize:13 weight:0.5];
    }
    else if(IS_IPAD_1X || IS_IPAD_2X)
    {
        m_UIButtonReady1.titleLabel.font = [UIFont systemFontOfSize:21 weight:0.5];
    }
    else if (IS_IPAD_PRO)
    {
        m_UIButtonReady1.titleLabel.font = [UIFont systemFontOfSize:24 weight:0.5];
    }
    else
    {
        m_UIButtonReady1.titleLabel.font = [UIFont systemFontOfSize:17 weight:1];
    }
    
    //[m_UIButtonReady1 setTitleColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonReady1 setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonReady1 setTitle:[NSString stringWithFormat:@"READY"] forState:UIControlStateNormal];
    
    //
    //Group 2
    //
    frm = m_UIViewGroup1.frame;
    frm.origin.y = 0;
    m_UIViewGroup2.frame = frm;
    
    //speaker 2
    frm = m_UIButtonHome1.frame;
    m_UIButtonSpeaker2.frame = frm;
    
    //home 2
    frm = m_UIButtonSpeaker1.frame;
    m_UIButtonHome2.frame = frm;
    
    //ready 2
    frm = m_UIButtonReady1.frame;
    m_UIButtonReady2.frame = frm;
    m_UIButtonReady2.layer.cornerRadius = 10;
    [m_UIButtonReady2 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    
    if (IS_IPHONE_4_OR_LESS)
    {
        m_UIButtonReady2.titleLabel.font = [UIFont systemFontOfSize:13 weight:0.5];
    }else if(IS_IPAD_1X || IS_IPAD_2X)
    {
        m_UIButtonReady2.titleLabel.font = [UIFont systemFontOfSize:21 weight:0.5];
    }
    else if (IS_IPAD_PRO)
    {
        m_UIButtonReady2.titleLabel.font = [UIFont systemFontOfSize:24 weight:0.5];
    }
    else
    {
        m_UIButtonReady2.titleLabel.font = [UIFont systemFontOfSize:17 weight:1];
    }
    //m_UIButtonReady2.titleLabel.font = [UIFont systemFontOfSize:17 weight:1];
    //[m_UIButtonReady2 setTitleColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonReady2 setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonReady2 setTitle:[NSString stringWithFormat:@"READY"] forState:UIControlStateNormal];
    
    m_UIButtonReady2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    m_UIButtonSpeaker2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    m_UIButtonHome2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    
    m_UILabelWin2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    m_UILabelScore2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    
    
    
    //[m_UIView1to50 setBackgroundColor:[UIColor lightGrayColor]];
    //[m_UIView51to100 setBackgroundColor:[UIColor lightGrayColor]];
    m_Array1to50Number = [[NSMutableArray alloc] init];
    for (NSUInteger i=0; i < 50; i++)
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
        //[MyNumber setBackgroundColor:[UIColor whiteColor]];
        [MyNumber setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]];
        MyNumber.layer.cornerRadius = 5;
        MyNumber.alpha = 1;
        [MyNumber addTarget:self action:@selector(NumberClick1:) forControlEvents:UIControlEventTouchUpInside];
        
        [m_UIView1to50 addSubview:MyNumber];
        [m_Array1to50Number addObject:MyNumber];
    }
    
    
    m_Array51to100Number = [[NSMutableArray alloc] init];
    frm = m_UIView51to100.frame;
    for (NSUInteger i=0; i < 50; i++)
    {
        CGFloat x = (i % 10) * (1.0/ 16 + 1) * w;
        CGFloat y = (i / 10) * (1.0/16 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake( frm.size.width- x - w, frm.size.height - y - h, w, h)];
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
        
        [MyNumber addTarget:self action:@selector(NumberClick2:) forControlEvents:UIControlEventTouchUpInside];
        [MyNumber setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%li", (long)(MyNumber.tag ) ] forState:UIControlStateNormal];
        //[MyNumber setBackgroundColor:[UIColor whiteColor]];
        [MyNumber setBackgroundColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1]];
        MyNumber.layer.cornerRadius = 5;
        MyNumber.alpha = 1;
        MyNumber.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    
        [m_UIView51to100 addSubview:MyNumber];
        [m_Array51to100Number addObject:MyNumber];
    }
    
    // view result 1
    CGRect frm1 = m_UIView1to50.frame;
    frm1.origin.y = frm1.size.height + m_UIViewGroup1.frame.size.height;
    m_UIViewResult1.frame = frm1;
    
    CGRect frm_youwin1;
    frm_youwin1.size.width = m_UIViewResult1.frame.size.width;
    frm_youwin1.size.height = 1.0/5 * m_UIViewResult1.frame.size.height;
    frm_youwin1.origin.x = 0;
    frm_youwin1.origin.y = 1.0/5 * m_UIViewResult1.frame.size.height;
    m_UILabelWin1.frame = frm_youwin1;
    
    CGRect frm_score1 = frm_youwin1;
    frm_score1.origin.y = 2.0/5 * m_UIViewResult1.frame.size.height;
    m_UILabelScore1.frame = frm_score1;
    
    
    CGRect frm_share;
    frm_share.size.width = 1.0/3 * m_UIViewResult1.frame.size.width;
    frm_share.size.height = 3.0/10 * m_UIViewResult1.frame.size.height;
    frm_share.origin.x = 1.0/2 * (m_UIViewResult1.frame.size.width - frm_share.size.width);
    frm_share.origin.y = 3.0/5 * m_UIViewResult1.frame.size.height;
    m_UIButtonShare.frame = frm_share;
    m_UIButtonShare.layer.cornerRadius = 10;
    [m_UIButtonShare setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    [m_UIButtonShare setHidden:true];
    //view result 2
    CGRect frm2 = m_UIView51to100.frame;
    frm2.origin.y = 0 - frm2.size.height - m_UIViewGroup2.frame.size.height;
    m_UIViewResult2.frame = frm2;
    
    CGRect frm_youwin2;
    frm_youwin2.size.width = m_UIViewResult2.frame.size.width;
    frm_youwin2.size.height = 1.0/5 * m_UIViewResult2.frame.size.height;
    frm_youwin2.origin.x = 0;
    frm_youwin2.origin.y = m_UIViewResult2.frame.size.height - 1.0/5 * m_UIViewResult2.frame.size.height - frm_youwin2.size.height;
    m_UILabelWin2.frame = frm_youwin2;
    
    CGRect frm_score2 = frm_youwin2;
    frm_score2.origin.y = m_UIViewResult2.frame.size.height - 2.0/5 * m_UIViewResult2.frame.size.height - frm_score2.size.height;
    m_UILabelScore2.frame = frm_score2;
    
    
    [m_UIView1to50 addSubview:m_UIViewResult1];
    [m_UIView51to100 addSubview:m_UIViewResult2];
    
}

- (IBAction)ShareScoreClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    NSString * message = @"#1 to 100 Numbers";
    UIImage * image = [[Configuration GetSingleton] TakeScreenshot];
    
    NSArray * shareItems = @[message, image];
    UIActivityViewController * ActivityVC = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    ActivityVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    ActivityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
    [self presentViewController:ActivityVC animated:YES completion:nil];
    
    ActivityVC.completionHandler = ^(NSString *activityType, BOOL completed)
    {
        if (completed)
        {
            NSLog(@"Selected activity was performed.");
        }
        else
        {
            if (activityType == NULL)
            {
                NSLog(@"User dismissed the view controller without making a selection.");
            } else
            {
                NSLog(@"Activity was not performed.");
            }
        }
    };

    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1000 && buttonIndex == 1)
    {
        //code for opening settings app in iOS 8
        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    }
}


- (void)NumberClick1: (UIButton*)sender
{
    [m_PlayLock lock];
    
    if (m_Sate == READY0 || m_Sate == READY1 || m_Sate == STOPGAME)
    {
        [m_PlayLock unlock];
        return;
    }
    
   
    if (sender.tag != m_CurrentNumber)
    {
        [m_PlayLock unlock];
        return;
    }
    
   [[SoundController GetSingleton] PlaySoundCorrect];
    
    m_ScorePlayer1 += 1;
    [m_TempNumber1 setBackgroundColor:[UIColor colorWithRed:201.0/255.0 green:220.0/255.0 blue:104.0/255.0 alpha:1]];
    [m_TempNumber2 setBackgroundColor:[UIColor colorWithRed:201.0/255.0 green:220.0/255.0 blue:104.0/255.0 alpha:1]];
    
    [sender setBackgroundColor:[UIColor yellowColor]];
    
    for (UIButton *l_number in m_Array51to100Number)
    {
        if (l_number.tag == sender.tag)
        {
            [l_number setBackgroundColor:[UIColor yellowColor]];
            m_TempNumber2 = l_number;
        }
    }
    
    
    if (m_CurrentNumber == 50)
    {
        
        [self GameOver];
    }
    else
    {
        m_TempNumber1 = sender;
        m_CurrentNumber += 1;
    }
    
    [m_PlayLock unlock];

}


- (void)NumberClick2: (UIButton*)sender
{
    [m_PlayLock lock];
    
    if (m_Sate == READY0 || m_Sate == READY1 || m_Sate == STOPGAME)
    {
        [m_PlayLock unlock];
        return;
    }
    
    
    if (sender.tag != m_CurrentNumber)
    {
        [m_PlayLock unlock];
        return;
    }
    
    [[SoundController GetSingleton] PlaySoundCorrect];
    m_ScorePlayer2 += 1;
    
    [m_TempNumber1 setBackgroundColor:[UIColor colorWithRed:201.0/255.0 green:220.0/255.0 blue:104.0/255.0 alpha:1]];
    [m_TempNumber2 setBackgroundColor:[UIColor colorWithRed:201.0/255.0 green:220.0/255.0 blue:104.0/255.0 alpha:1]];
    
    [sender setBackgroundColor:[UIColor yellowColor]];
    for (UIButton *l_number in m_Array1to50Number)
    {
        if (l_number.tag == sender.tag)
        {
             [l_number setBackgroundColor:[UIColor yellowColor]];
            m_TempNumber2 = l_number;
        }
    }
   
    
    if (m_CurrentNumber == 50)
    {
        [self GameOver];
    }
    else
    {
        
        m_TempNumber1 = sender;
        m_CurrentNumber += 1;
    }
    
    [m_PlayLock unlock];
    
}


- (void) GameOver
{
    [[SoundController GetSingleton] PlaySoundGameOver];
    if (m_ScorePlayer1 > m_ScorePlayer2)
    {
        m_UILabelWin2.text = @"YOU LOSE";
        m_UILabelWin1.text = @"YOU WIN";
    }
    else if (m_ScorePlayer1 < m_ScorePlayer2)
    {
        m_UILabelWin2.text = @"YOU WIN";
        m_UILabelWin1.text = @"YOU LOSE";
    }
    else
    {
        m_UILabelWin2.text = @"SAME POINT";
        m_UILabelWin1.text = @"SAME POINT";
    }
    
    m_UILabelScore1.text = [NSString stringWithFormat:@"%li / 50", (long)m_ScorePlayer1];
    m_UILabelScore2.text = [NSString stringWithFormat:@"%li / 50", (long)m_ScorePlayer2];
    
    m_Sate = STOPGAME;
    [self ShowResult];
}

- (void) ShowResult
{
    CGRect frm1 = m_UIView1to50.frame;
    frm1.origin.y = 0;
    
    CGRect frm2 = m_UIView51to100.frame;
    frm2.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    m_UIViewResult1.frame = frm1;
    m_UIViewResult2.frame = frm2;
    [UIView commitAnimations];
}


- (void) HideResult
{
    CGRect frm1 = m_UIView1to50.frame;
    frm1.origin.y = frm1.size.height + m_UIViewGroup1.frame.size.height;
    
    CGRect frm2 = m_UIView51to100.frame;
    frm2.origin.y = -frm2.size.height - m_UIViewGroup2.frame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    m_UIViewResult1.frame = frm1;
    m_UIViewResult2.frame = frm2;
    [UIView commitAnimations];
}


- (IBAction)ReadyClick:(UIButton*)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    
    if (m_Sate == READY0 || m_Sate == READY1)
    {
        m_Sate++;
        if (m_Sate == READY2)
        {
            m_CurrentNumber = 1;
            m_ScorePlayer1 = 0;
            m_ScorePlayer2 = 0;
            m_TempNumber1 = nil;
            m_TempNumber2 = nil;
            
            m_UIButtonReady1.enabled = TRUE;
            m_UIButtonReady2.enabled = TRUE;
            m_UIButtonReady1.alpha = 1;
            m_UIButtonReady2.alpha = 1;
            
            [self ReArange20BodyIcon];
        }
        else
        {
            sender.alpha = 0.5;
            sender.enabled = FALSE;
        }
    }
    else if(m_Sate == READY2)
    {
        if ([sender isEqual:m_UIButtonReady1])
        {
            m_ScorePlayer1 = 0;
            m_ScorePlayer2 = 50;
        }
        else
        {
            m_ScorePlayer1 = 50;
            m_ScorePlayer2 = 0;
        }
        
        //m_Sate = REJECTGAME;
        [self GameOver];
    }
    else if(m_Sate == REJECTGAME || m_Sate == STOPGAME)
    {
        m_Sate = READY1;
        sender.alpha = 0.5;
        sender.enabled = FALSE;
        [self HideResult];
    }
    
}


- (void)ReArange20BodyIcon
{
    for (NSUInteger i = m_Array1to50Number.count-1; i > 0; i--)
    {
        NSUInteger j = (NSUInteger)arc4random_uniform(i+1);
        [m_Array1to50Number exchangeObjectAtIndex:i withObjectAtIndex:j];
        [m_Array51to100Number exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    
        NSInteger i = 0;
        for (UIButton *l_Number in m_Array1to50Number)
        {
            [l_Number setBackgroundColor:[UIColor whiteColor]];
            CGRect frm = l_Number.frame;
            frm.origin.x = (i % 10) * (1.0/ 20 + 1) * frm.size.width;
            frm.origin.y = (i / 10) * (1.0/20 + 1) * frm.size.height;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.6];
            l_Number.frame = frm;
            [UIView commitAnimations];
            
            i++;
        }
    
        i = 0;
        CGRect frmV = m_UIView51to100.frame;
        for (UIButton *l_Number in m_Array51to100Number)
        {
            //[l_Number setBackgroundImage:nil forState:UIControlStateNormal];
            [l_Number setBackgroundColor:[UIColor whiteColor]];
            CGRect frm = l_Number.frame;
            frm.origin.x = frmV.size.width-(i % 10) * (1.0/ 20 + 1) * frm.size.width - frm.size.width;
            frm.origin.y = frmV.size.height -(i / 10) * (1.0/20 + 1) * frm.size.height - frm.size.height;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.6];
            l_Number.frame = frm;
            [UIView commitAnimations];
            
            i++;
        }
    
    
}



- (IBAction)SpeakerClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [self ShowSpeaker];
}


- (IBAction)HomeClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}


- (void) ShowSpeaker
{
    if ([[SoundController GetSingleton] GetMute])
    {
        [m_UIButtonSpeaker1 setImage:[UIImage imageNamed:@"btn_mute.png"] forState: UIControlStateNormal];
        [m_UIButtonSpeaker2 setImage:[UIImage imageNamed:@"btn_mute.png"] forState: UIControlStateNormal];
    }
    else
    {
        [m_UIButtonSpeaker1 setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
        [m_UIButtonSpeaker2 setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
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
