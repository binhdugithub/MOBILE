
//
//  1PlayerViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "SinglePlayerViewController.h"
#import "SingleResultViewController.h"
#import  "StatisticsViewController.h"
#import "SoundController.h"

#define TIME_MAX 300
@interface SinglePlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UIView *m_UIView100Number;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonPlay;
@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UIlabelCopyright;

@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonStatistics;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTime;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonHome;

@property (weak, nonatomic) IBOutlet UIImageView *m_UIImageViewBackGround;

@property (nonatomic, strong)NSMutableArray *m_Array100Number;
@property (nonatomic, assign)NSInteger m_CurrentNumber;
@property (nonatomic, assign)NSInteger  m_Sate;
@property (strong, nonatomic) NSTimer *m_Timer;

@end

@implementation SinglePlayerViewController
@synthesize m_UIButtonPlay, m_UIView100Number, m_UIViewFooter,m_UIlabelCopyright, m_UIViewHeader;
@synthesize m_UIButtonSpeaker, m_UIButtonStatistics, m_UIButtonHome,m_UIImageViewBackGround;
@synthesize m_UILabelTime;
@synthesize m_Array100Number, m_CurrentNumber;
@synthesize m_Sate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    
    [self ShowSpeaker];
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
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
  
    //1 bacground
    CGRect frm = m_UIImageViewBackGround.frame;
    frm.size.width = W;
    frm.size.height = H;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIImageViewBackGround.frame = frm;
    
    //2. Header
    frm = m_UIViewHeader.frame;
    frm.size.width = W;
    frm.size.height = 3.0/2 * 1.0/9 * W;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIViewHeader.frame = frm;
    // About
    frm = m_UIButtonHome.frame;
    frm.size.width = 1.0/9 * W;
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/4 * frm.size.width;
    frm.origin.y = 1.0/4 * frm.size.height;
    m_UIButtonHome.frame =frm;
    
    //Speaker
    frm.origin.x = m_UIViewHeader.frame.size.width - frm.size.width - 1.0/4 * frm.size.width;
    m_UIButtonSpeaker.frame = frm;
    
    //statistics
    frm.origin.x = 1.0/2 * (m_UIViewHeader.frame.size.width - frm.size.width);
    m_UIButtonStatistics.frame = frm;
    
    //time
    frm = m_UIViewHeader.frame;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTime.frame = frm;
    
    //3 100Numbers
    frm = m_UIView100Number.frame;
    frm.size.width = W;
    frm.size.height = frm.size.width;
    frm.origin.x = 0;
    frm.origin.y = m_UIViewHeader.frame.size.height;
    m_UIView100Number.frame = frm;
    
    // 4 play
    
    frm = m_UIButtonPlay.frame;
    frm.size.width = 1.0/2 * W;
    frm.size.height = 1.0/12 * H;
    frm.origin.x = 1.0/4 * W;
    frm.origin.y = m_UIView100Number.frame.origin.y + m_UIView100Number.frame.size.height + frm.size.height * 1.0/4;
    m_UIButtonPlay.frame = frm;
    
    //5Footer
    frm = m_UIViewFooter.frame;
    frm.size.width = W;
    frm.size.height = H - (m_UIButtonPlay.frame.origin.y + 5.0/4 * m_UIButtonPlay.frame.size.height);
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    m_UIViewFooter.frame = frm;
    
    //Copyrith
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIlabelCopyright.frame = frm;
    
   
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
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:13 weight:5];
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [MyNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%i", (MyNumber.tag) ] forState:UIControlStateNormal];
        [MyNumber setBackgroundColor:l_number.backgroundColor];
        MyNumber.alpha = l_number.alpha;
        
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
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/8 + 10);
    CGFloat h = w;
    
    CGRect frm = m_UIView100Number.frame;
    frm.origin.x = 0;
    frm.size.width = [UIScreen mainScreen].bounds.size.width;
    frm.size.height = [UIScreen mainScreen].bounds.size.width;
    m_UIView100Number.frame = frm;
    
    for (NSUInteger i=0; i < 100; i++)
    {
        CGFloat x = (i % 10) * (1.0/ 8 + 1) * w;
        CGFloat y = (i / 10) * (1.0/8 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        MyNumber.frame = CGRectMake(x, y, w, h);
        MyNumber.tag = i + 1;
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:13 weight:5];
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [MyNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [MyNumber setTitle:[NSString stringWithFormat:@"%i", (MyNumber.tag) ] forState:UIControlStateNormal];
        [MyNumber setBackgroundColor:[UIColor yellowColor]];
        MyNumber.alpha = 0.8;
        
        //[m_UIView100Number setBackgroundColor:[UIColor whiteColor]];
        [m_UIView100Number addSubview:MyNumber];
        
        [m_Array100Number addObject:MyNumber];
    }
}

- (void)ReArange100Number
{
    for (u_int32_t i = m_Array100Number.count-1; i > 0; i--)
        [m_Array100Number exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform(i+1)];
    
    NSInteger i = 0;
    for (UIButton *MyNumber in m_Array100Number)
    {
        CGRect frm = MyNumber.frame;
        CGFloat x = (i % 10) * (1.0/ 8 + 1) * frm.size.width;
        CGFloat y = (i / 10) * (1.0/8 + 1) * frm.size.height;
        
        frm.origin.x = x;
        frm.origin.y = y;
        MyNumber.frame = frm;
        
        [MyNumber setBackgroundColor:[UIColor whiteColor]];
        MyNumber.alpha = 0.8;
        
        i++;
    }
}

- (void)ShowTimeDurration
{
    //m_UILabelTime.layer.transform = CATransform3DMakeRotation(M_PI, 0.0f, 1.0f, 0.0f);
    m_UILabelTime.text = [NSString stringWithFormat:@"%i", TIME_MAX];
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
    NSString *str_time = m_UILabelTime.text;
    NSInteger int_time = [str_time integerValue] - 1;
    m_UILabelTime.text = [NSString stringWithFormat:@"%i", int_time];
    if (int_time == 0)
    {
        [p_timer invalidate];
        p_timer = nil;
        NSLog(@"Time out");
        [self GameOver];
    }
}

- (void)NumberClick: (UIButton*)sender
{
    if (sender.tag <= m_CurrentNumber)
        return;
    
    switch (m_Sate)
    {
        case FIRSTWIEW:
        case BACKVIEW:
            return;
        case PREPAREPLAY:
        {
            //m_UILabelTime.text = [NSString stringWithFormat:@"%i", TIME_MAX];
            [self ShowTimeDurration];
            _m_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0
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
        [sender setBackgroundColor:[UIColor greenColor]];
        
        if (m_CurrentNumber == 100)
        {
            [self GameWin];
        }
    }
    else
    {
        NSLog(@"Press button: %i", sender.tag);
        [sender setBackgroundColor:[UIColor redColor]];
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
    m_CurrentNumber = 0;
    
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
        [_m_Timer invalidate];
        _m_Timer = nil;
        
        m_Sate = PREPAREPLAY;
        [self HideTimeDurration];
        [self ReArange100Number];
    }
}

- (void)GameOver
{
    NSLog(@"Keu game over !!)");
    [[SoundController GetSingleton] PlaySoundGameOver];
    [self performSegueWithIdentifier:@"SegueSingleResult" sender:self];
}

- (void)GameWin
{
    [[SoundController GetSingleton] PlaySoundCongratulation];
    
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
        SingleResultViewController *MyView = (SingleResultViewController*)[segue destinationViewController];
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
