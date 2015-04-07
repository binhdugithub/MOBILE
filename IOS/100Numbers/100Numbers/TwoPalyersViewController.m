//
//  2PalyersViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "TwoPalyersViewController.h"
#import "SoundController.h"

enum
{
    READY0,
    READY1,
    READY2,
    
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
}

@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker1;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker2;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonPlayer1;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonPlayer2;
@property (weak, nonatomic) IBOutlet UIView *m_UIView51to100;
@property (weak, nonatomic) IBOutlet UIView *m_UIView1to50;

@end

@implementation TwoPalyersViewController
@synthesize m_UIButtonSpeaker1, m_UIButtonSpeaker2;
@synthesize m_UIView1to50, m_UIView51to100;



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self ShowSpeaker];
    [self InitView];
    m_Sate = READY0;
    m_CurrentNumber = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)InitView
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/16 + 10);
    CGFloat h = w;
    CGRect frm = m_UIView1to50.frame;
    frm.origin.x = 0;
    frm.size.width = [UIScreen mainScreen].bounds.size.width;
    frm.size.height = [UIScreen mainScreen].bounds.size.width / 2;
    m_UIView1to50.frame = frm;
    
    
    frm = m_UIView51to100.frame;
    frm.origin.x = 0;
    frm.size.width = [UIScreen mainScreen].bounds.size.width;
    frm.size.height = [UIScreen mainScreen].bounds.size.width / 2;
    m_UIView51to100.frame = frm;
    
    
    m_Array1to50Number = [[NSMutableArray alloc] init];
    for (NSUInteger i=0; i < 50; i++)
    {
        CGFloat x = (i % 10) * (1.0/ 16 + 1) * w;
        CGFloat y = (i / 10) * (1.0/16 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        MyNumber.frame = CGRectMake(x, y, w, h);
        MyNumber.tag = i + 1;
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:11 weight:3];
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [MyNumber setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%i", (MyNumber.tag) ] forState:UIControlStateNormal];
        [MyNumber setBackgroundColor:[UIColor yellowColor]];
         MyNumber.alpha = 1;
        
        [m_UIView1to50 setBackgroundColor:[UIColor blackColor]];
        [m_UIView1to50 addSubview:MyNumber];
        
        [m_Array1to50Number addObject:MyNumber];
    }
    
    
    m_Array51to100Number = [[NSMutableArray alloc] init];
    for (NSUInteger i=50; i < 100; i++)
    {
        NSInteger j= i % 50;
       
        CGFloat x = (j % 10) * (1.0/ 16 + 1) * w;
        CGFloat y = (j / 10) * (1.0/16 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        MyNumber.frame = CGRectMake(x, y, w, h);
        MyNumber.tag = i + 1;
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:11 weight:3];
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [MyNumber setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%i", (MyNumber.tag - 50) ] forState:UIControlStateNormal];
        [MyNumber setBackgroundColor:[UIColor yellowColor]];
        MyNumber.alpha = 1;
        
        [m_UIView51to100 setBackgroundColor:[UIColor blackColor]];
        [m_UIView51to100 addSubview:MyNumber];
        
        [m_Array51to100Number addObject:MyNumber];
    }
}

- (void)NumberClick: (UIButton*)sender
{
    if (m_Sate == READY0 || m_Sate == READY1)
        return;
    
    NSInteger l_tag = (sender.tag > 50)? (sender.tag - 50) : (sender.tag);
    if (l_tag != m_CurrentNumber)
        return;
    
    if (sender.tag <= 50)
    {
        m_ScorePlayer1 += 1;
        m_CurrentNumber += 1;
        sender.alpha = 0.8;
        [sender setBackgroundColor:[UIColor greenColor]];
        for (UIButton *l_number in m_Array51to100Number)
        {
            if (l_number.tag == sender.tag + 50)
            {
                [l_number setBackgroundColor:[UIColor greenColor]];
            }
        }
        if (m_CurrentNumber == 100)
        {
            [self Player1Win];
        }
    }
    else
    {
        m_ScorePlayer2 += 1;
        m_CurrentNumber += 1;
        sender.alpha = 0.8;
        [sender setBackgroundColor:[UIColor greenColor]];
        for (UIButton *l_number in m_Array1to50Number)
        {
            if (l_number.tag == sender.tag - 50)
            {
                [l_number setBackgroundColor:[UIColor greenColor]];
            }
        }
        if (m_CurrentNumber == 100)
        {
            [self Player2Win];
        }
    }
    
}

- (void) Player1Win
{
    
}

- (void) Player2Win
{
    
}

- (IBAction)Player1Click:(id)sender
{
    if (m_Sate != READY2)
    {
        m_Sate++;
        if (m_Sate == READY2)
        {
            m_CurrentNumber = 1;
            m_ScorePlayer1 = 0;
            m_ScorePlayer2 = 0;
        }
    
    }
    else
    {
        
    }
    
}


- (IBAction)Player2Click:(id)sender
{
    if (m_Sate != READY2)
    {
        m_Sate++;
        if (m_Sate == READY2)
        {
            m_CurrentNumber = 1;
            m_ScorePlayer1 = 0;
            m_ScorePlayer2 = 0;
        }
    }
    else
    {
        
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
