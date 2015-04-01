//
//  PlayViewController.m
//  Correct
//
//  Created by Binh Du  on 3/22/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "PlayViewController.h"
#import "HomeViewController.h"
#import "ResultViewController.h"
#import "MyIcon.h"


#define TIME_2_START_CORRECT 10
#define ICON_PER_ROW 4
#define ROWS 5
#define DELTA_TIME 20


@interface PlayViewController ()

@property (strong, nonatomic)  UIView *m_VHeader;
@property (strong, nonatomic)  UIView *m_VFooter;
@property (strong, nonatomic)  UIView *m_VBody;
@property (strong, nonatomic)  UIImageView *m_UIImageScore;
@property (strong, nonatomic)  UIImageView *m_UIImageTime;
@property (strong, nonatomic)  UIButton *m_btnPre;
@property (strong, nonatomic)  UIButton *m_btnNext;
@property (strong, nonatomic)  UILabel  *m_lblTime;
@property (strong, nonatomic)  UIButton *m_btnHome;

@property (strong, nonatomic) NSMutableArray *m_Array20IconFooter;
@property  (strong, nonatomic) NSMutableArray *m_Array4Icon;
@property (strong, nonatomic) NSMutableArray *m_Array20IconBody;
@property (strong, nonatomic) NSMutableArray *m_Array20ImageIcon;
@property (strong, nonatomic) NSMutableArray *m_Array20ImageScore;

@property (nonatomic, strong) UISwipeGestureRecognizer *m_SwipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *m_SwipeRight;

@property (nonatomic, strong) IBOutlet UIView *dropTarget;
@property (nonatomic, strong) UIView *dragObject;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;
@property (nonatomic, assign) NSInteger m_StartIconPosition;
@property (nonatomic, assign) NSInteger m_score;
@property (nonatomic, assign) NSInteger m_currentTime;
@property (nonatomic, assign) NSInteger m_time2Stop;
@property (nonatomic, assign) NSInteger m_level;
@property (nonatomic, assign) BOOL m_IsStart;
@property (nonatomic, assign) BOOL m_IsMute;

@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayer;


@end

@implementation PlayViewController

@synthesize m_VBody, m_VFooter, m_VHeader;
@synthesize m_Array20IconFooter, m_Array20IconBody, m_Array4Icon, m_Array20ImageScore;
@synthesize m_Array20ImageIcon;
@synthesize m_btnNext, m_btnPre;
@synthesize m_SwipeLeft, m_SwipeRight;
@synthesize m_UIImageScore, m_UIImageTime;
@synthesize m_lblTime, m_btnHome;

@synthesize dropTarget;
@synthesize dragObject;
@synthesize touchOffset;
@synthesize homePosition;
@synthesize m_StartIconPosition;
@synthesize m_score,m_currentTime, m_time2Stop, m_level;
@synthesize m_IsStart, m_IsMute;
@synthesize m_AudioPlayer;

float m_WIcon;
float m_HIcon;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%.0f", [[UIScreen mainScreen] bounds].size.width);
    NSLog(@"%.0f", [[UIScreen mainScreen] bounds].size.height);
    m_WIcon = ([[UIScreen mainScreen] bounds].size.width) * (4.0/21) ;
    m_HIcon = ([[UIScreen mainScreen] bounds].size.height) * (1.0/ 9); // 1/2Y la noi tinh diem
    printf("\nm_WIcon: %f", m_WIcon);
    printf("\nm_HIcon: %f", m_HIcon);

    
    m_IsStart = false;
    m_score = 0;
    m_currentTime =0;
    [self LoadData];
    
    
    
    m_SwipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(HandleSWipe:)];
    m_SwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    m_SwipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(HandleSWipe:)];
    m_SwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [m_VFooter addGestureRecognizer:m_SwipeRight];
    [m_VFooter addGestureRecognizer:m_SwipeLeft];

    //init body and footer button : default 20bodybutton and 4footerbutton
    m_Array20IconFooter = [[NSMutableArray alloc] init];
    m_Array20IconBody =   [[NSMutableArray alloc] init];
    m_Array4Icon = [[NSMutableArray alloc]init];
    m_Array20ImageScore = [[NSMutableArray alloc]init];
    m_Array20ImageIcon = [[NSMutableArray alloc] init];
    
    //.1
    [self Init20Image4Icon];
    [self Init20Image4Score];
    //.2
    [self Init3Regions];
    [self Init44Icon];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(StartMotionGame:)
                                   userInfo:nil
                                    repeats:NO];


    
}

- (void) PlaySoundClick
{
    if(m_IsMute)
        return;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
    NSURL *mp3URL = [NSURL fileURLWithPath:path];
    m_AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    [m_AudioPlayer play];
}

- (void) PlaySoundGameOver
{
    if(m_IsMute)
        return;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gameover" ofType:@"mp3"];
    NSURL *mp3URL = [NSURL fileURLWithPath:path];
    m_AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    [m_AudioPlayer play];
}

- (void) PlaySoundCongratulation
{
    if(m_IsMute)
        return;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"congratulation" ofType:@"mp3"];
    NSURL *mp3URL = [NSURL fileURLWithPath:path];
    m_AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    [m_AudioPlayer play];
}

- (void) PlaySoundCorrect
{
    if(m_IsMute)
        return;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"mp3"];
    NSURL *mp3URL = [NSURL fileURLWithPath:path];
    m_AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    [m_AudioPlayer play];
}

- (void)LoadData
{
    NSString *pathData = [[NSBundle mainBundle] pathForResource: @"Data" ofType:@"plist"];
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        m_level = [dicData[@"Level"] intValue];
        NSInteger timeMax = [dicData[@"TimeMax"] intValue];
        m_time2Stop = timeMax - (m_level -1) * DELTA_TIME;
    }
    else
    {
        NSLog(@"Load User info fail !!");
    }


}

- (void)SetMuteState: (BOOL)p_state
{
    m_IsMute = p_state;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

- (void)StartMotionGame: (NSTimer*)p_timer
{
    m_currentTime = m_time2Stop;
    [m_lblTime setText:[NSString stringWithFormat:@"%ld", (long)m_currentTime]];
    
    //motion for 20icon in body
    [self ReArange20BodyIcon];
    
    //motion for 4button in foooter
    for (NSInteger i=0; i<4 ;i++)
    {
        UIImageView *l_footerIcon = m_Array4Icon[i];
        CGRect frameIcon = l_footerIcon.frame;
        CGFloat x = 1.0/4 * m_WIcon + i* 5.0/4 * m_WIcon;
        frameIcon.origin.y = 7.75 * m_HIcon;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        l_footerIcon.frame = CGRectMake(x, frameIcon.origin.y, m_WIcon, m_HIcon);
        [UIView commitAnimations];
     
    }
    
    //SetTime to start game
    [NSTimer scheduledTimerWithTimeInterval:TIME_2_START_CORRECT
                                     target:self
                                   selector:@selector(StartCorrect:)
                                   userInfo:nil
                                    repeats:NO];

}


- (void)StartCorrect: (NSTimer *)p_timer
{
    m_IsStart = TRUE;
    
    for (MyIcon *l_tempIcon in m_Array20IconBody)
    {
        [l_tempIcon SetStateIcon:NOTCORRECTED];
    }
    
    m_StartIconPosition =arc4random() % (m_Array20IconFooter.count);
    [self Show4IconFooter];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(SetTimeRest:)
                                   userInfo:nil
                                    repeats:YES];
    
}


- (void) SetTimeRest: (NSTimer *)p_timer
{
    m_currentTime -= 1;
    //[self RotationClock];
    [m_lblTime setText:[NSString stringWithFormat:@"%ld", (long)m_currentTime]];
    
    if (m_currentTime <= 0 || m_IsStart == FALSE)
    {
        [p_timer invalidate];
        [self ShowResultView];
    }
}


- (void)RotationClock
{
    [UIView beginAnimations:nil context:NULL];
    {
        [UIView setAnimationDuration:0.0];
        //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationDelegate:self];
        m_UIImageTime.transform = CGAffineTransformMakeRotation(m_currentTime * 6 * M_PI / 180);
    }
    [UIView commitAnimations];
    
}

- (void)ShowResultView
{
    [self performSegueWithIdentifier:@"SegueResult" sender:self];
}

- (void)HomeClick
{
    [self PlaySoundClick];
    [self performSegueWithIdentifier:@"SegueBackHome" sender:self];
}


- (void)Init20Image4Icon
{
    for(int i=1; i<= ICON_PER_ROW * ROWS; i++)
        [m_Array20ImageIcon addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%u.png", i]]];
    
}

- (void)Init20Image4Score
{
    for(int i=0; i<= ICON_PER_ROW * ROWS; i++)
        [m_Array20ImageScore addObject:[UIImage imageNamed:[NSString stringWithFormat:@"level_%u.png", i]]];
    
}

- (void)AddScore
{
    m_score += 1;
    //m_UIImageScore.image = m_Array20ImageScore[m_score];
}

- (BOOL)Congratulation
{
    if (m_score == 20) {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    
    return FALSE;
}


- (void)InitHeader
{
    //Header
    m_VHeader = [[UIView alloc]init];
    CGRect l_HeaderFrm = m_VHeader.frame;
    l_HeaderFrm.size.width = [[UIScreen mainScreen] bounds].size.width;
    l_HeaderFrm.size.height = 1* m_HIcon;
    l_HeaderFrm.origin.x = 0;
    l_HeaderFrm.origin.y = 0;
    m_VHeader.frame = l_HeaderFrm;
    
    //1.home
    CGFloat x = 1.0/8 * m_WIcon;
    CGFloat y = 1.0/8 * m_HIcon;
    CGFloat w = 3.0/4 * m_WIcon;
    CGFloat h = 3.0/4 * m_HIcon;
    m_btnHome = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [m_btnHome setBackgroundImage:[UIImage imageNamed:@"btn_home.png"] forState:UIControlStateNormal];
    [m_btnHome addTarget:self action:@selector(HomeClick) forControlEvents:UIControlEventTouchUpInside];
    
    //2.Score
    x = 17.0/8 * m_WIcon;
    y = 1.0/8 * m_HIcon;
    w = m_WIcon;
    h = 3.0/4 * m_HIcon;
    m_UIImageScore = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    //m_UIImageScore.image = [UIImage imageNamed:@"score_0.png"];
    m_UIImageScore.image = m_Array20ImageScore[m_level];
    
    
    //3. time
    x = [UIScreen mainScreen].bounds.size.width - 1.0/8 * m_WIcon - 3.0/4 * m_WIcon;
    y = 1.0/8 * m_HIcon;
    w = 3.0/4 * m_HIcon;
    h = 3.0/4 * m_HIcon;
    
    m_UIImageTime = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    m_UIImageTime.image = [UIImage imageNamed:@"bg_clock.png"];
    
    m_lblTime = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [m_lblTime setTextAlignment:NSTextAlignmentCenter];
    [[self m_lblTime] setTextColor:[UIColor whiteColor]];
    [[self m_lblTime] setFont:[UIFont fontWithName:@"System" size:40]];
    //[m_lblTime setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"notcorrected.png"]]];
    
    
    [m_VHeader addSubview:m_btnHome];
    [m_VHeader addSubview:m_UIImageScore];
    [m_VHeader addSubview:m_UIImageTime];
    [m_VHeader addSubview:m_lblTime];

    //[m_VHeader setBackgroundColor:[UIColor grayColor]];
    
}

- (void)InitBody
{
    //Body
    m_VBody = [[UIView alloc]init];
    CGRect l_BodyFrm = m_VBody.frame;
    l_BodyFrm.size.width = [[UIScreen mainScreen] bounds].size.width;
    l_BodyFrm.size.height = 13.0/2 * m_HIcon;
    l_BodyFrm.origin.x = 0;
    l_BodyFrm.origin.y = [m_VHeader frame].size.height;
    m_VBody.frame = l_BodyFrm;
}

- (void)InitFooter
{
    //Footer
    m_VFooter = [[UIView alloc]init];
    CGRect l_FooterFrm = m_VFooter.frame;
    l_FooterFrm.size.width = [[UIScreen mainScreen] bounds].size.width;
    l_FooterFrm.size.height = 3.0/2 * m_HIcon;
    l_FooterFrm.origin.x = 0;
    l_FooterFrm.origin.y = [m_VHeader frame].size.height + [m_VBody frame].size.height;
    m_VFooter.frame = l_FooterFrm;
    
    m_btnNext = [[UIButton alloc]init];
    m_btnNext.frame = CGRectMake(5 * m_WIcon, 1.0/4 * m_HIcon, 1.0/4 * m_WIcon, m_HIcon);
    
    m_btnPre = [[UIButton alloc]init];
    m_btnPre.frame = CGRectMake(0, 1.0/4 * m_HIcon, 1.0/4 * m_WIcon, m_HIcon);
    
    [m_btnNext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [m_btnNext addTarget:self action:@selector(NextFooter:) forControlEvents:UIControlEventTouchUpInside];
    
    [m_btnPre setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
    [m_btnPre addTarget:self action:@selector(PreFooter:) forControlEvents:UIControlEventTouchUpInside];
    
    [m_VFooter addSubview:m_btnNext];
    [m_VFooter addSubview:m_btnPre];
    //[m_VFooter setBackgroundColor:[UIColor grayColor]];

}

- (void)Init3Regions
{
    //1. Init background
    
   // bg_uiimage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //[self.view addSubview:bg_uiimage];

    //2. Init header
    [self InitHeader];
    [self InitBody];
    [self InitFooter];
    
    m_VHeader.alpha = 0.8;
    m_VFooter.alpha = 0.8;

    [self.view addSubview:m_VHeader];
    [self.view addSubview:m_VBody];
    [self.view addSubview:m_VFooter];
}


- (void)Init44Icon
{
    //Init 20 Body button
    CGFloat x = [UIScreen mainScreen].bounds.size.width/2 - m_WIcon/2;
    CGFloat y = [UIScreen mainScreen].bounds.size.height/2 - m_HIcon/2;
    
    for (NSInteger i=0; i < ICON_PER_ROW * ROWS; i++)
    {
        MyIcon *l_tempIcon = [[MyIcon alloc] initWithFrame:CGRectMake(x, y, m_WIcon, m_HIcon)];
        l_tempIcon.tag = i;
        [l_tempIcon SetNormalImage:m_Array20ImageIcon[i]
                    NotCorectedImage:[UIImage imageNamed:@"notcorrected.png"]
                    CorrectingImage:[UIImage imageNamed:@"correcting.png"]
                    SuggestImage:[UIImage imageNamed:@"suggest.png"]];
        
        [l_tempIcon SetStateIcon:NOTCORRECTED];
        [self.view addSubview:l_tempIcon];
        [m_Array20IconBody addObject:l_tempIcon];
        
    }
    
    //Init 20 Footer Button
    for (NSInteger i=0; i < ICON_PER_ROW * ROWS; i++)
    {
        
        MyIcon *l_tempIcon = [[MyIcon alloc] initWithFrame:CGRectMake(0, 0, m_WIcon, m_HIcon)];
        l_tempIcon.tag = i;
        [l_tempIcon SetNormalImage:m_Array20ImageIcon[i]
                    NotCorectedImage:[UIImage imageNamed:@"notcorrected.png"]
                    CorrectingImage:[UIImage imageNamed:@"correcting.png"]
                    SuggestImage:[UIImage imageNamed:@"suggest.png"]];
        
        [m_Array20IconFooter addObject:l_tempIcon];
        
    }
    
    
    //Init 4 Footer Button
    for (NSInteger i=0 ; i < 4; i++)
    {
        UIImageView *l_footerIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"notcorrected.png"]];
        
        l_footerIcon.tag = -1;
        l_footerIcon.frame = CGRectMake(x, y, m_WIcon, m_HIcon);
        
        l_footerIcon.userInteractionEnabled = YES;
        UISwipeGestureRecognizer *l_SwipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(HandleSWipe:)];
        l_SwipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        
        UISwipeGestureRecognizer *l_SwipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(HandleSWipe:)];
        l_SwipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        UIPanGestureRecognizer *l_Pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(HandlePan:)];
        
        [l_Pan requireGestureRecognizerToFail:l_SwipeLeft];
        [l_Pan requireGestureRecognizerToFail:l_SwipeRight];
        [l_Pan requireGestureRecognizerToFail:m_SwipeLeft];
        [l_Pan requireGestureRecognizerToFail:m_SwipeRight];
        
        [l_footerIcon addGestureRecognizer:l_SwipeLeft];
        [l_footerIcon addGestureRecognizer:l_SwipeRight];
        [l_footerIcon addGestureRecognizer:l_Pan];
        
        
        [m_Array4Icon addObject:l_footerIcon];
        [self.view addSubview:l_footerIcon];
    }
}


- (void)ReArange20BodyIcon
{
    for (NSUInteger i = m_Array20IconBody.count-1; i > 0; i--)
        [m_Array20IconBody exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform(i+1)];
    
    NSInteger i = 1;
    for (MyIcon *l_tempIcon in m_Array20IconBody)
    {
        float l_row = ceil(i/4.0);
        
        CGFloat x;
        if(i%ICON_PER_ROW != 0)
            x = (i % ICON_PER_ROW) * 1.0/ICON_PER_ROW * m_WIcon + ((i % ICON_PER_ROW) - 1)* m_WIcon;
        else
            x = ICON_PER_ROW * 1.0/ICON_PER_ROW * m_WIcon + (ICON_PER_ROW - 1)* m_WIcon;
        
        CGFloat y = 1.0*m_HIcon + l_row * 1.0/4 * m_HIcon + (l_row - 1)* m_HIcon;
        
        [l_tempIcon SetStateIcon:NORMAL];
        [l_tempIcon MoveToX:x ToY:y];
        
        i++;
        
    }
    
}


- (void)ReArrange20FooterIcon
{
    for (NSUInteger i = m_Array20IconFooter.count-1; i > 0; i--)
    {
        [m_Array20IconFooter exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform(i+1)];
    }
}


- (void)Show4IconFooter
{
    //reset notcorrect for all icon what not correct
    for (MyIcon *l_icon in m_Array20IconBody)
        if ([l_icon GetStateIcon] != CORRECTED)
            [l_icon SetStateIcon:NOTCORRECTED];
    
    NSInteger l_size = m_Array20IconFooter.count;
    NSInteger l_EndIconPosition = 0;

    //printf("\nSize : %d Position: %d",l_size, m_StartIconPosition);
    if (l_size < ICON_PER_ROW)
    {
        m_StartIconPosition = 0;
        l_EndIconPosition = l_size;
    }
    else
    {
        m_StartIconPosition = (m_StartIconPosition > 0 )? m_StartIconPosition % l_size : (m_StartIconPosition + l_size) % l_size;
        l_EndIconPosition = m_StartIconPosition + ICON_PER_ROW;

    }
    
    NSInteger k = 0;
    for (NSInteger i = m_StartIconPosition; i < l_EndIconPosition; i++)
    {
        UIImageView *l_icon = m_Array4Icon[k++];
        l_icon.tag = [m_Array20IconFooter[i%l_size] GetTag];
        
        l_icon.image = [m_Array20IconFooter[i%l_size] GetNormalImage];
        [self SuggestIconWithTag:l_icon.tag];
        /*if (m_IsStart)
        {
            l_icon.image = [m_Array20IconFooter[i%l_size] GetNormalImage];
            [self SuggestIconWithTag:l_icon.tag];
        }else
        {
            l_icon.image = [UIImage imageNamed:@"notcorrected.png"];
        }*/
    }
    
    
    if (l_size < ICON_PER_ROW)
    {
        for (NSInteger j = l_size; j < ICON_PER_ROW; j++)
        {
            UIImageView *l_icon = m_Array4Icon[j];
            l_icon.image = [UIImage imageNamed:@"notcorrected.png"];
        }
    }
    
}

- (void)SuggestIconWithTag: (NSInteger) tag
{
    for (MyIcon *l_icon in m_Array20IconBody)
    {
        if ([l_icon GetTag] == tag) {
            [l_icon SetStateIcon:SUGGEST];
            break;
        }
    }
}


- (void)HandlePan: (UIPanGestureRecognizer*)sender
{
    if(!m_IsStart || m_currentTime == 0)
        return;
    
    switch (sender.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            if ([sender numberOfTouches] == 1)
            {
                // one finger
                CGPoint touchPoint = [sender locationInView:self.view];
                self.dragObject = sender.view;
                self.touchOffset = CGPointMake(touchPoint.x - sender.view.frame.origin.x,
                                               touchPoint.y - sender.view.frame.origin.y);
                self.homePosition = CGPointMake(sender.view.frame.origin.x,
                                                sender.view.frame.origin.y);
                [self.view bringSubviewToFront:self.dragObject];
                
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            
            CGPoint  touchPoint = [sender locationInView:self.view];
            CGRect newDragObjectFrame = CGRectMake(touchPoint.x - touchOffset.x,
                                                   touchPoint.y - touchOffset.y,
                                                   self.dragObject.frame.size.width,
                                                   self.dragObject.frame.size.height);
            self.dragObject.frame = newDragObjectFrame;
            
            
            for(MyIcon *l_tempIcon in m_Array20IconBody)
            {
                if([l_tempIcon GetStateIcon] == CORRECTED ||
                    [l_tempIcon GetStateIcon] == NOTCORRECTED)
                    continue;
                
                if (touchPoint.x > l_tempIcon.frame.origin.x &&
                    touchPoint.x < l_tempIcon.frame.origin.x + l_tempIcon.frame.size.width &&
                    touchPoint.y > l_tempIcon.frame.origin.y &&
                    touchPoint.y < l_tempIcon.frame.origin.y + l_tempIcon.frame.size.height )
                {
                    if (self.dragObject != NULL)
                    {
                        [l_tempIcon SetStateIcon:CORRECTING];
                    }
                    
                }
                else
                {
                    [l_tempIcon SetStateIcon:SUGGEST];
                    
                }
                
            }
        }
            break;
        
        case UIGestureRecognizerStateEnded:
        {
            CGPoint touchPoint = [sender locationInView:self.view];
            for(MyIcon *l_tempIcon in m_Array20IconBody)
            {
                if ([l_tempIcon GetStateIcon] == CORRECTED ||
                     [l_tempIcon GetStateIcon] == NOTCORRECTED)
                {
                    continue;
                }
                
                if (touchPoint.x > l_tempIcon.frame.origin.x &&
                    touchPoint.x < l_tempIcon.frame.origin.x + l_tempIcon.frame.size.width &&
                    touchPoint.y > l_tempIcon.frame.origin.y &&
                    touchPoint.y < l_tempIcon.frame.origin.y + l_tempIcon.frame.size.height )
                {
                    if (self.dragObject != NULL && l_tempIcon.tag == self.dragObject.tag)
                    {
                        [l_tempIcon SetStateIcon:CORRECTED];
                        [self RemoveFooterIconAtIndex:self.dragObject.tag];
                        [self AddScore];
                        
                        if (m_Array20IconFooter.count > 4)
                        {
                            m_StartIconPosition =arc4random() % (m_Array20IconFooter.count);
                            
                            //m_StartIconPosition += 4
                        }
                        else
                        {
                           m_StartIconPosition = 0;
                        }
                        
                        
                        [self Show4IconFooter];
                        
                        if ([self Congratulation])
                        {
                            m_IsStart = FALSE;
                            [self PlaySoundCongratulation];
                        }
                        else
                        {
                            [self PlaySoundCorrect];
                        }
                        
                    }
                    else
                    {
                        m_IsStart = FALSE;
                        [l_tempIcon SetStateIcon:SUGGEST];
                        [self PlaySoundGameOver];
                    }
                    
                    break;
                    
                }
                
            }
            
            
            self.dragObject.frame = CGRectMake(self.homePosition.x, self.homePosition.y,
                                                   self.dragObject.frame.size.width,
                                                   self.dragObject.frame.size.height);
            
            self.dragObject = NULL;
            
        }
            
            break;
            
        case UIGestureRecognizerStatePossible:
            printf("\nUIGestureRecognizerStatePossible");
            break;
            
        default:
            break;
    }
    
}

- (void)RemoveFooterIconAtIndex:(NSInteger) index
{
    for (int i= 0; i < m_Array20IconFooter.count; i++)
    {
        if ([m_Array20IconFooter[i] GetTag] == index)
        {
            [m_Array20IconFooter removeObjectAtIndex:i];
        }
    }
}

- (void)HandleSWipe:(UISwipeGestureRecognizer*)sender
{
    if (!m_IsStart || m_Array20IconFooter.count <= ICON_PER_ROW) {
        return;
    }
    
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *)sender direction];
    
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            m_StartIconPosition += 4;
            [self Show4IconFooter];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            m_StartIconPosition -= 4;
             [self Show4IconFooter];
            break;
            
        default:
            break;
    }
}




- (IBAction)NextFooter:(id)sender
{
    [self PlaySoundClick];
    if (!m_IsStart || m_Array20IconFooter.count <= ICON_PER_ROW) {
        return;
    }
    
    m_StartIconPosition += 4;
    [self Show4IconFooter];
}

- (IBAction)PreFooter:(id)sender
{
    [self PlaySoundClick];
    if (!m_IsStart || m_Array20IconFooter.count <= ICON_PER_ROW) {
        return;
    }
    
    m_StartIconPosition -= 4;
    [self Show4IconFooter];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SegueBackHome"])
    {

    }
    
    if ([[segue identifier] isEqualToString:@"SegueResult"])
    {
        ResultViewController *MyView = (ResultViewController*)[segue destinationViewController];
        [MyView SetLevel:m_level];
        [MyView SetCurrentTime:m_currentTime];
        [MyView SetScore:m_score];
        [MyView SetIsMute:m_IsMute];
    }
}


@end

