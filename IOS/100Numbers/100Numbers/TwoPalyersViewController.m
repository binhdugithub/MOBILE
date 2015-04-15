//
//  2PalyersViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "TwoPalyersViewController.h"
#import "SoundController.h"
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

@end

@implementation TwoPalyersViewController
@synthesize m_UIButtonSpeaker1, m_UIButtonSpeaker2;
@synthesize m_UIView1to50, m_UIView51to100;
@synthesize m_UIViewResult1, m_UIViewResult2;
@synthesize m_UIButtonReady1, m_UIButtonReady2;
@synthesize m_UIButtonHome2;
@synthesize m_UILabelScore1, m_UILabelScore2;
@synthesize m_UILabelWin1, m_UILabelWin2;
@synthesize m_UIButtonHome1, m_UIViewFooter, m_UILabelCopyright;
@synthesize m_UIViewGroup1, m_UIViewGroup2;
@synthesize m_UILabelCopyright2;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [[GADMasterViewController singleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
    [self ShowSpeaker];
    m_Sate = READY0;
    m_CurrentNumber = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //1 bacground
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:238.0/255.0 blue:169.0/255.0 alpha:1]];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    //2. group 1
    CGRect frm = m_UIViewGroup1.frame;
    frm.size.width = W;
    frm.size.height = 1.0/3 * (H - W);
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    m_UIViewGroup1.frame = frm;
    
    //speaker1
    frm = m_UIButtonSpeaker1.frame;
    frm.size.height = 1.0/2 * m_UIViewGroup1.frame.size.height;
    frm.size.width = frm.size.height;
    frm.origin.x = 1.0/4 * frm.size.width;
    frm.origin.y = 1.0/2 *(m_UIViewGroup1.frame.size.height - frm.size.height);
    m_UIButtonSpeaker1.frame = frm;
    //home 1
    frm = m_UIButtonSpeaker1.frame;
    frm.origin.x = m_UIViewGroup1.frame.size.width - 1.0/4 * frm.size.width - frm.size.width;
    m_UIButtonHome1.frame = frm;
    //ready 1
    frm = m_UIViewGroup1.frame;
    frm.size.width = 1.0/2 * frm.size.width;
    frm.size.height = frm.size.height - 1.0/4 * frm.size.height;
    frm.origin.x = 1.0/4 * m_UIViewGroup1.frame.size.width;
    frm.origin.y = 1.0/8 * m_UIViewGroup1.frame.size.height;
    m_UIButtonReady1.frame = frm;
    m_UIButtonReady1.layer.cornerRadius = 10;
    [m_UIButtonReady1 setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:104.0/255.0 blue:175.0/255.0 alpha:1]];
    
    //3 group 2
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
    [m_UIButtonReady2 setBackgroundColor:[UIColor colorWithRed:131.0/255.0 green:104.0/255.0 blue:175.0/255.0 alpha:1]];
    
    //4 group advertisement
    frm = m_UIViewGroup1.frame;
    frm.origin.y = m_UIViewGroup2.frame.size.height + 1.0/2 * W;
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
    
    //5 1->50
    frm = m_UIView1to50.frame;
    frm.size.width = W;
    frm.size.height = 1.0/2 * W;
    frm.origin.x = 0;
    frm.origin.y = m_UIViewFooter.frame.origin.y + m_UIViewFooter.frame.size.height;
    m_UIView1to50.frame = frm;
    //51 -> 100
    frm = m_UIView1to50.frame;
    frm.origin.y = m_UIViewGroup2.frame.origin.y + m_UIViewGroup2.frame.size.height;
    m_UIView51to100.frame = frm;
    
    m_UIButtonReady2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    m_UIButtonSpeaker2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    m_UIButtonHome2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    
    m_UILabelWin2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    m_UILabelScore2.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/16 + 10);
    CGFloat h = w;
    
    
    m_Array1to50Number = [[NSMutableArray alloc] init];
    for (NSUInteger i=0; i < 50; i++)
    {
        CGFloat x = (i % 10) * (1.0/ 16 + 1) * w;
        CGFloat y = (i / 10) * (1.0/16 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        MyNumber.frame = CGRectMake(x, y, w, h);
        MyNumber.tag = i + 1;
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:13 weight:1];
        [MyNumber addTarget:self action:@selector(NumberClick1:) forControlEvents:UIControlEventTouchUpInside];
        
        [MyNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%li", (long)(MyNumber.tag) ] forState:UIControlStateNormal];
        MyNumber.alpha = 1;
        
        [m_UIView1to50 setBackgroundColor:[UIColor whiteColor]];
        
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
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:13 weight:1];
        [MyNumber addTarget:self action:@selector(NumberClick2:) forControlEvents:UIControlEventTouchUpInside];
        
        [MyNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%li", (long)(MyNumber.tag ) ] forState:UIControlStateNormal];
        MyNumber.alpha = 1;
        
        [m_UIView51to100 setBackgroundColor:[UIColor whiteColor]];
        MyNumber.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
        
        [m_UIView51to100 addSubview:MyNumber];
        [m_Array51to100Number addObject:MyNumber];
    }
    
    
    CGRect frm1 = m_UIView1to50.frame;
    frm1.origin.y = frm1.size.height;
    m_UIViewResult1.frame = frm1;
    
    CGRect frm2 = m_UIView51to100.frame;
    frm2.origin.y = - frm2.size.height;
    m_UIViewResult2.frame = frm2;
    
    [m_UIView1to50 addSubview:m_UIViewResult1];
    [m_UIView51to100 addSubview:m_UIViewResult2];
    
}

- (void)NumberClick1: (UIButton*)sender
{
    if (m_Sate == READY0 || m_Sate == READY1)
        return;
    
   
    if (sender.tag != m_CurrentNumber)
        return;
    
   
    m_ScorePlayer1 += 1;
    [m_TempNumber1 setBackgroundImage:[UIImage imageNamed:@"bg_number_found.png"] forState:UIControlStateNormal];
    [m_TempNumber2 setBackgroundImage:[UIImage imageNamed:@"bg_number_found.png"] forState:UIControlStateNormal];
    
    //sender.alpha = 0.8;
    //[sender setBackgroundColor:[UIColor greenColor]];
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_number_lastfound.png"] forState:UIControlStateNormal];
    for (UIButton *l_number in m_Array51to100Number)
    {
        if (l_number.tag == sender.tag)
        {
            //[l_number setBackgroundColor:[UIColor greenColor]];
            [l_number setBackgroundImage:[UIImage imageNamed:@"bg_number_lastfound.png"] forState:UIControlStateNormal];
            //l_number.alpha = 0.8;
            
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

}


- (void)NumberClick2: (UIButton*)sender
{
    if (m_Sate == READY0 || m_Sate == READY1)
        return;
    
    
    if (sender.tag != m_CurrentNumber)
        return;
    
    
    m_ScorePlayer2 += 1;
    [m_TempNumber1 setBackgroundImage:[UIImage imageNamed:@"bg_number_found.png"] forState:UIControlStateNormal];
    [m_TempNumber2 setBackgroundImage:[UIImage imageNamed:@"bg_number_found.png"] forState:UIControlStateNormal];
    
    //sender.alpha = 0.8;
    //[sender setBackgroundColor:[UIColor greenColor]];
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_number_lastfound.png"] forState:UIControlStateNormal];
    for (UIButton *l_number in m_Array1to50Number)
    {
        if (l_number.tag == sender.tag)
        {
            //[l_number setBackgroundColor:[UIColor greenColor]];
            [l_number setBackgroundImage:[UIImage imageNamed:@"bg_number_lastfound.png"] forState:UIControlStateNormal];
            //l_number.alpha = 0.8;
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
        m_CurrentNumber += 1;    }
    
}


- (void) GameOver
{
    
    if (m_ScorePlayer1 < m_ScorePlayer2)
    {
        m_UILabelWin2.text = @"YOU WIN";
        m_UILabelWin1.text = @"YOU LOSE";
    }
    else
    {
        m_UILabelWin2.text = @"YOU LOSE";
        m_UILabelWin1.text = @"YOU WIN";
    }
    
    m_UILabelScore1.text = [NSString stringWithFormat:@"%li / 50", (long)m_ScorePlayer1];
    m_UILabelScore2.text = [NSString stringWithFormat:@"%li / 50", (long)m_ScorePlayer2];
    
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
    frm1.origin.y = frm1.size.height;
    
    CGRect frm2 = m_UIView51to100.frame;
    frm2.origin.y = -frm2.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    m_UIViewResult1.frame = frm1;
    m_UIViewResult2.frame = frm2;
    [UIView commitAnimations];
}


- (IBAction)ReadyClick:(UIButton*)sender
{
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
        
        m_Sate = REJECTGAME;
        [self GameOver];
    }
    else if(m_Sate == REJECTGAME || m_Sate == STOPGAME)
    {
        m_Sate = READY0;
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
            [l_Number setBackgroundImage:nil forState:UIControlStateNormal];
            CGRect frm = l_Number.frame;
            frm.origin.x = (i % 10) * (1.0/ 16 + 1) * frm.size.width;
            frm.origin.y = (i / 10) * (1.0/16 + 1) * frm.size.height;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            l_Number.frame = frm;
            [UIView commitAnimations];
            
            i++;
        }
        
        
        i = 0;
        CGRect frmV = m_UIView51to100.frame;
        for (UIButton *l_Number in m_Array51to100Number)
        {
            [l_Number setBackgroundImage:nil forState:UIControlStateNormal];
            CGRect frm = l_Number.frame;
            frm.origin.x = frmV.size.width-(i % 10) * (1.0/ 16 + 1) * frm.size.width - frm.size.width;
            frm.origin.y = frmV.size.height -(i / 10) * (1.0/16 + 1) * frm.size.height - frm.size.height;
            
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
