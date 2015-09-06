//
//  ViewController.m
//  DifferentColor
//
//  Created by Nguyễn Thế Bình on 8/11/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "PlayViewController.h"
#import "Define.h"


@interface PlayViewController ()
{
    NSMutableArray *m_Array100Number;
    NSInteger m_Level;
    
    bool m_GameCenterEnabled;
    NSString *m_LeaderboardIdentifier;
    
    
    //NSInteger m_Score;
    CGFloat m_Time;
    NSLock *m_TimeLock;
    NSInteger m_Error;
    
    NSInteger m_State;
    
    NSTimer *m_TimerStart;
    NSTimer *m_TimerEnd;
    
}

@property (weak, nonatomic) IBOutlet UIView *ViewBody;
@property (weak, nonatomic) IBOutlet UIView *ViewButtons;
@property (weak, nonatomic) IBOutlet UIView *ViewFooter;
@property (weak, nonatomic) IBOutlet UIButton *BtnSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *BtnRate;
@property (weak, nonatomic) IBOutlet UIButton *BtnGameCenter;


//Header
@property (weak, nonatomic) IBOutlet UIView *ViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *LblTitle;
@property (weak, nonatomic) IBOutlet UILabel *LblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *LblScore;
@property (weak, nonatomic) IBOutlet UILabel *BtnScore;
@property (weak, nonatomic) IBOutlet UILabel *LblError;
@property (weak, nonatomic) IBOutlet UILabel *BtnError;
@property (weak, nonatomic) IBOutlet UILabel *LblTime;
@property (weak, nonatomic) IBOutlet UILabel *BtnTime;
@property (weak, nonatomic) IBOutlet UIButton *BtnHelp;

@end

@implementation PlayViewController
@synthesize ViewBody, ViewButtons, ViewFooter, BtnSpeaker, BtnGameCenter;
@synthesize ViewHeader, LblError, LblScore, LblSubTitle, LblTime, LblTitle;
@synthesize BtnError, BtnHelp, BtnScore, BtnTime;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self CalculateView];
    [self ShowSpeaker];
    [self FreshGame];
    
    m_Array100Number = nil;
    m_Level = 0;
    //m_Score = 0;
    m_Time = 15;
    m_Error = 0;
    m_TimerStart = nil;
    m_TimerEnd = nil;
    m_State = PREPAREPLAY;
    
    
    [self AuthenticateLocalPlayer];
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:ViewFooter.frame];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if(([[Configuration GetSingleton] GetTimePlay] % 3) == 0)
    {
        NSLog(@"View ads");
        [[GADMasterViewController GetSingleton] ResetAdInterstitialView:self];
    }
    else
    {
        NSLog(@"Timeplay: %li", [[Configuration GetSingleton] GetTimePlay]);
    }
    
    [self NextLevel];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)CalculateView
{
    //
    //Background
    //
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main.png"]]];
    
    
    //
    // Header View
    //
    CGRect frm;
    if(IS_IPHONE_4_OR_LESS)
    {
        NSLog(@"Thi is IPHONE 4");
        frm.size.width = SCREEN_WIDTH - 2 *(SCREEN_WIDTH / 60.0);
        frm.size.height = 100;
    }
    else if(IS_IPHONE_5)
    {
        NSLog(@"Thi is IPHONE 5");
        frm.size.width = SCREEN_WIDTH - 2 * (SCREEN_WIDTH / 60.0);
        frm.size.height = 120;
    }
    else if(IS_IPAD)
    {
        NSLog(@"Thi is IPAD");
        frm.size.width = SCREEN_WIDTH -  4* (SCREEN_WIDTH / 60.0);
        frm.size.height = 150;
    }
    else if(IS_IPHONE_6)
    {
        NSLog(@"Thi is IPAD");
        frm.size.width = SCREEN_WIDTH -  2* (SCREEN_WIDTH / 60.0);
        frm.size.height = 130;
        
    }else if(IS_IPHONE_6P)
    {
        NSLog(@"Thi is IPAD");
        frm.size.width = SCREEN_WIDTH -  2* (SCREEN_WIDTH / 60.0);
        frm.size.height = 150;
        
    }
    
    frm.origin.x = 1.0/2 * (SCREEN_WIDTH - frm.size.width);
    frm.origin.y = 0;
    ViewHeader.frame = frm;
    [ViewHeader setBackgroundColor:[UIColor clearColor]];
    
    //title
    frm.size.width = ViewHeader.frame.size.width;//5.0/8 * ViewHeader.frame.size.width;
    frm.size.height = 1.0/4 * ViewHeader.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    LblTitle.frame = frm;
    [LblTitle setFont:[UIFont systemFontOfSize:22 weight:1]];
    if (IS_IPAD) {
        [LblTitle setFont:[UIFont systemFontOfSize:25 weight:1]];
    }
    [LblTitle setTextColor:[UIColor blueColor]];
    
    //subtitile
    frm = LblTitle.frame;
    frm.size.height = 1.0/2 * LblTime.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = LblTitle.frame.origin.y + LblTitle.frame.size.height;
    LblSubTitle.frame = frm;
    [LblSubTitle setFont:[UIFont systemFontOfSize:10 weight:1]];
    if (IS_IPAD) {
        [LblSubTitle setFont:[UIFont systemFontOfSize:13 weight:1]];
    }
    [LblSubTitle setTextColor:[UIColor darkGrayColor]];
    
    //BtnSpeaker
    frm.size.height = LblTitle.frame.size.height - 5;
    frm.size.width = frm.size.height;
    frm.origin.x = ViewHeader.frame.size.width - frm.size.width;
    frm.origin.y = 1.0/2 * (LblTitle.frame.size.height - frm.size.height);
    BtnSpeaker.frame = frm;
    
    
    //BtnTime
    if(IS_IPAD)
        frm.size.width = 1.0/3 * (ViewHeader.frame.size.width);
    else
        frm.size.width = 1.0/3 * (ViewHeader.frame.size.width);
    
    CGFloat l_fontsize = 15;
    CGFloat l_fontbutton = 20;
    if (IS_IPHONE_4_OR_LESS)
    {
        l_fontsize = 13;
        l_fontbutton = 18;
    }
    if (IS_IPAD)
    {
        l_fontsize = 18;
        l_fontbutton = 23;
    }
    
    CGFloat l_fontweight = 0.2;
    frm.size.height = 1.0/2 * ViewHeader.frame.size.height;
    frm.origin.x = 1.0/2 *(ViewHeader.frame.size.width - frm.size.width);
    frm.origin.y = ViewHeader.frame.size.height - frm.size.height;// + 1.0/2 * (frm.size.height - 1.0/4 * ViewHeader.frame.size.height);
    BtnTime.frame = frm;
    [BtnTime setBackgroundColor:[UIColor clearColor]];
    [BtnTime setTextColor:[UIColor greenColor]];
    [BtnTime setFont:[UIFont systemFontOfSize:35 weight:l_fontweight]];
    if (IS_IPAD) {
        [BtnTime setFont:[UIFont systemFontOfSize:40 weight:l_fontweight]];

    }
    
    
    //LblTime
    
    LblTime.hidden = TRUE;
    
    //LblError
    frm.size.width = 1.0/2 * (ViewHeader.frame.size.width -BtnTime.frame.size.width);
    frm.size.height = 1.0/4 * ViewHeader.frame.size.height;
    frm.origin.x = ViewHeader.frame.size.width - frm.size.width ;
    frm.origin.y = 1.0/2 * ViewHeader.frame.size.height;
    LblError.frame = frm;
    [LblError setTextColor:[UIColor blackColor]];
    [LblError setTextAlignment:NSTextAlignmentCenter];
    [LblError setFont:[UIFont systemFontOfSize:l_fontsize weight:l_fontweight]];
    
    
    //BtnError
    frm = LblError.frame;
    frm.origin.y = ViewHeader.frame.size.height - frm.size.height;
    BtnError.frame = frm;
    //[BtnError setBackgroundColor:[UIColor colorWithRed:76.0/255 green:235.0/255 blue:141/255.0 alpha:1]];
    [BtnError setBackgroundColor:[UIColor clearColor]];
    [BtnError setTextColor:[UIColor redColor]];
    [BtnError setTextAlignment:NSTextAlignmentCenter];
    [BtnError setFont:[UIFont systemFontOfSize:l_fontbutton weight:l_fontweight]];
    
    //LblScore
    frm = LblError.frame;
    frm.origin.x = 0;
    LblScore.frame = frm;
    [LblScore setTextColor:[UIColor blackColor]];
    [LblScore setTextAlignment:NSTextAlignmentCenter];
    [LblScore setFont:[UIFont systemFontOfSize:l_fontsize weight:l_fontweight]];
    
    //BtnSocre
    frm = LblScore.frame;
    frm.origin.y = ViewHeader.frame.size.height - frm.size.height;
    BtnScore.frame = frm;
    [BtnScore setBackgroundColor:[UIColor clearColor]];
    //[BtnScore setBackgroundColor:[UIColor colorWithRed:76.0/255 green:235.0/255 blue:141/255.0 alpha:1]];
    [BtnScore setTextColor:[UIColor redColor]];
    [BtnScore setTextAlignment:NSTextAlignmentCenter];
    [BtnScore setFont:[UIFont systemFontOfSize:l_fontbutton weight:l_fontweight]];
    

    //
    //Body
    //
    
    frm = ViewBody.frame;
    frm.size.width = SCREEN_WIDTH;
    if(IS_IPAD)
        frm.size.width = SCREEN_WIDTH - 2 *(SCREEN_WIDTH / 60.0);
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/2 *(SCREEN_WIDTH - frm.size.width);
    if (IS_IPHONE_4_OR_LESS || IS_IPAD)
    {
        frm.origin.y = ViewHeader.frame.origin.y + ViewHeader.frame.size.height + 1.0/2 *(BtnTime.frame.size.height - BtnError.frame.size.height) + 5;
    }
    else
    {
        frm.origin.y = ViewHeader.frame.origin.y + ViewHeader.frame.size.height + 1.0/2 *(BtnTime.frame.size.height - BtnError.frame.size.height) + 5;
    }
    
    
    ViewBody.frame = frm;
    [ViewBody setBackgroundColor:[UIColor clearColor]];
    
    //3 Footer
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = 50;
    frm.origin.x = 0;
    frm.origin.y = SCREEN_HEIGHT - frm.size.height;
    
    if (IS_IPHONE_4_OR_LESS) {
        frm.size.height = 0;
    }
    
    ViewFooter.frame = frm;
    [ViewFooter setBackgroundColor:[UIColor clearColor]];
    
    //
    //Controller Button
    //
    frm = ViewButtons.frame;
    frm.size.width = ViewHeader.frame.size.width;
    frm.size.height = SCREEN_HEIGHT - ViewBody.frame.size.height - ViewBody.frame.origin.y - ViewFooter.frame.size.height;
    frm.origin.x = ViewHeader.frame.origin.x;
    frm.origin.y = ViewBody.frame.size.height + ViewBody.frame.origin.y;
    ViewButtons.frame = frm;
    [ViewButtons setBackgroundColor:[UIColor clearColor]];
    
    //if(IS_IPAD)
        l_fontbutton -= 5;
    //BtnHelp
    frm.size.width = 1.0/3 * (ViewButtons.frame.size.width - 20);
    frm.size.height = ViewButtons.frame.size.height * 3.0/4;
    frm.origin.x = 0;
    frm.origin.y = 1.0/2 *(ViewButtons.frame.size.height - frm.size.height);
    BtnHelp.frame = frm;
    [BtnHelp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [BtnHelp.titleLabel setFont:[UIFont systemFontOfSize:l_fontbutton weight:l_fontweight]];
    [BtnHelp setTitle:@"HELP" forState:UIControlStateNormal];
    CGFloat l_radius = 0.1 * frm.size.height;
    BtnHelp.layer.cornerRadius = l_radius;
    [BtnHelp setBackgroundColor:[UIColor colorWithRed:76/255.0 green:157/255.0 blue:231/255.0 alpha:1]];
    
    //Rate
    frm = BtnHelp.frame;
    frm.origin.x = 1.0/2 *(ViewButtons.frame.size.width - frm.size.width);
    _BtnRate.frame = frm;
    
    [_BtnRate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_BtnRate.titleLabel setFont:[UIFont systemFontOfSize:l_fontbutton weight:l_fontweight]];
    [_BtnRate setTitle:@"RATE" forState:UIControlStateNormal];
    _BtnRate.layer.cornerRadius = l_radius;
    [_BtnRate setBackgroundColor:[UIColor colorWithRed:76/255.0 green:157/255.0 blue:231/255.0 alpha:1]];
    
    //GameCenter
    frm = _BtnRate.frame;
    frm.origin.x = ViewButtons.frame.size.width - frm.size.width;
    BtnGameCenter.frame = frm;
    [BtnGameCenter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [BtnGameCenter.titleLabel setFont:[UIFont systemFontOfSize:l_fontbutton weight:l_fontweight]];
    [BtnGameCenter setTitle:@"RANK" forState:UIControlStateNormal];
    BtnGameCenter.layer.cornerRadius = l_radius;
    [BtnGameCenter setBackgroundColor:[UIColor colorWithRed:76/255.0 green:157/255.0 blue:231/255.0 alpha:1]];
    
    
    
}

- (void)NextLevel
{
    //m_Level++;
    int l_number_of_box = 0;
    int l_numberbox_on_row = 0;
    int l_delta_color = 0;
    if (m_Level <= 1)
    {
        //NSLog(@"Number box on row: %i", l_numberbox_on_row);
        l_number_of_box = 4;
        l_numberbox_on_row = 2;
        l_delta_color = 10;
        
    }
    else if(m_Level <= 3)
    {
        l_number_of_box = 9;
        l_numberbox_on_row = 3;
        //l_delta_color = 8;
    }
    else if(m_Level <= 7)
    {
        l_number_of_box = 16;
        l_numberbox_on_row = 4;
        //l_delta_color = 6;
    }
    else if(m_Level <= 12)
    {
        l_number_of_box = 25;
        l_numberbox_on_row = 5;
        //l_delta_color = 4;
    }
    else if(m_Level <= 20)
    {
        l_number_of_box = 36;
        l_numberbox_on_row = 6;
        //l_delta_color = 2;
    }
    else if(m_Level >= 21)
    {
        l_number_of_box = 49;
        l_numberbox_on_row = 7;
    }
    
    int p_score = (int)m_Level;
    if (p_score <= 4 && p_score >=0)
    {
        l_delta_color = 16;
    }
    else if (p_score <= 9 && p_score >=5)
    {
        l_delta_color = 14;
    }
    else if (p_score <= 14 && p_score >=10)
    {
        l_delta_color = 12;
    }
    else if (p_score <= 19 && p_score >=15)
    {
        l_delta_color = 10;
    }
    else if (p_score <= 24 && p_score >=20)
    {
        l_delta_color = 8;
    }
    else if (p_score <= 29 && p_score >= 25)
    {
        l_delta_color = 6;
    }
    else if (p_score <= 34 && p_score >= 30)
    {
        l_delta_color = 4;
    }
    else if (p_score >= 35)
    {
        l_delta_color = 2;
    }
    
    
    if(m_Array100Number != nil)
    {
        for (UIButton *MyButton in m_Array100Number) {
            
            //[m_ArrayAnswerButton removeObject:MyButton];
            [MyButton removeFromSuperview];
        }
        
        [m_Array100Number removeAllObjects];
        
    }
    else
        m_Array100Number = [[NSMutableArray alloc] init];

    CGFloat W_SPACE = SCREEN_WIDTH / 60.0;
    CGFloat W_BOX = (ViewBody.frame.size.width - W_SPACE *(l_numberbox_on_row + 1)) / l_numberbox_on_row;
    
    int l_color_red1 = arc4random_uniform(212);
    int l_color_red2 = arc4random_uniform(212);
    int l_color_red3 = arc4random_uniform(212);
    CGFloat l_color_red = 1.0/3 * (l_color_red1 + l_color_red2 + l_color_red3);
    
    int l_color_green1 = arc4random_uniform(212);
    int l_color_green2 = arc4random_uniform(212);
    int l_color_green3 = arc4random_uniform(212);
    CGFloat l_color_green= 1.0/3 * (l_color_green1 + l_color_green2 + l_color_green3);
    
    int l_color_blue1 = arc4random_uniform(212);
    int l_color_blue2 = arc4random_uniform(212);
    int l_color_blue3 = arc4random_uniform(212);
    CGFloat l_color_blue = 1.0/3 * (l_color_blue1 + l_color_blue2 + l_color_blue3);
    
    
    int l_true_box = arc4random_uniform(l_number_of_box - 1);
    
    ///NSLog(@"Color red: %i, green: %i, blue: %i", l_color_red, l_color_green, l_color_blue);
    NSLog(@"Delta Color: %i", l_delta_color);
    NSLog(@"True box: %i", l_true_box + 1);
    
    for (NSUInteger i= 0; i < l_number_of_box; i++)
    {
        NSInteger l_column = i % l_numberbox_on_row;
        NSInteger l_row = i / l_numberbox_on_row;
        CGFloat x = (l_column + 1) * W_SPACE + l_column * W_BOX;
        CGFloat y = (l_row + 1) * W_SPACE + l_row * W_BOX;
        
        UIButton *MyBox = [[UIButton alloc] init];
        MyBox.frame = CGRectMake(x, y, W_BOX, W_BOX);
        
        MyBox.tag = i;
        if (i == l_true_box)
        {
            [MyBox setBackgroundColor:[UIColor colorWithRed:(l_color_red + l_delta_color)/255.0 green:(l_color_green + l_delta_color)/255 blue:(l_color_blue + l_delta_color)/255 alpha:1]];
            [MyBox addTarget:self action:@selector(TrueBoxClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [MyBox setBackgroundColor:[UIColor colorWithRed:l_color_red/255.0 green:l_color_green/255 blue:l_color_blue/255 alpha:1]];
            [MyBox addTarget:self action:@selector(FailBoxClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        MyBox.layer.cornerRadius = 5;
        
        
        [ViewBody addSubview:MyBox];
        [m_Array100Number addObject:MyBox];
    };
    
    
}


- (IBAction)TrueBoxClick:(id)sender
{
    [[SoundController GetSingleton] PlaySoundCorrect];
    
    if (m_State == PREPAREPLAY || m_State == GAMEOVER)
    {
        m_State = PLAYING;
    }
    
    if (m_State == PLAYING)
    {
        if(m_TimerEnd != nil && m_TimerStart == nil)
        {
            //NSLog(@"Vao day");
            [m_TimerEnd invalidate];
            m_TimerEnd = nil;
            [BtnTime setTextColor:[UIColor greenColor]];
            m_TimerStart = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                            target:self
                                                          selector:@selector(TimeOutStart:)
                                                          userInfo:nil
                                                           repeats:YES];
        }
        else if(m_TimerEnd == nil && m_TimerStart == nil)
        {
            m_TimerStart = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(TimeOutStart:)
                                                     userInfo:nil
                                                      repeats:YES];
        }
        
        
        [m_TimeLock lock];
        m_Time = 15;
        [BtnTime setText:[NSString stringWithFormat:@"%li", (long)m_Time]];
        [m_TimeLock unlock];
        
        m_Level++;
        [BtnScore setText:[NSString stringWithFormat:@"%li", (long)m_Level]];
        [self NextLevel];
        //NSLog(@"You have clicked true box");
    }
    else
    {
        NSLog(@"Game not playing");
    }
}


- (IBAction)FailBoxClick:(id)sender
{
    if (m_State == PLAYING)
    {
        [[SoundController GetSingleton] PlaySoundFail];
        [m_TimeLock lock];
        m_Time -= 3;
        m_Time = m_Time >=0 ? m_Time : 0;
        
        [m_TimeLock unlock];
        m_Error += 1;
        [BtnError setText:[NSString stringWithFormat:@"%li", (long)m_Error]];
        //NSLog(@"You have clicked fail box");
    }
}

- (void)TimeOutStart: (NSTimer*)p_timer
{
    [m_TimeLock lock];
    m_Time -= 1;
    m_Time = m_Time >=0 ? m_Time : 0;
    [m_TimeLock unlock];
    
    [BtnTime setText:[NSString stringWithFormat:@"%li", (long)m_Time]];
    
    if(m_Time <= 5)
    {
        [m_TimerStart invalidate];
        m_TimerStart = nil;
        [BtnTime setTextColor:[UIColor redColor]];
        m_TimerEnd = [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                       selector:@selector(TimeOutEnd:)
                                       userInfo:nil
                                        repeats:YES];
        
        
    }
    
}


- (void)TimeOutEnd: (NSTimer*)p_timer
{
    [m_TimeLock lock];
    m_Time -= 0.1;
    m_Time = m_Time >=0 ? m_Time : 0;
    [m_TimeLock unlock];
    
    //////////
    NSInteger l_1 = (long)m_Time;
    NSInteger l_2 = (m_Time - l_1) * 10;
    
    UIFont *l_bigfont = nil;
    l_bigfont = [UIFont systemFontOfSize:35 weight:0.2];
    if(IS_IPAD)
        l_bigfont = [UIFont systemFontOfSize:40 weight:0.2];
    
    UIFont *l_smallfont = nil;
    l_smallfont = [UIFont systemFontOfSize:25 weight:0.2];
    if(IS_IPAD)
        l_smallfont = [UIFont systemFontOfSize:30 weight:0.2];

    
    NSDictionary *BigAttributes = @{NSFontAttributeName:l_bigfont};
    NSDictionary *SmallAttributes = @{NSFontAttributeName:l_smallfont};
    //NSDictionary *highlightAttributes = @{NSFontAttributeName:font2, NSForegroundColorAttributeName:TextColor};
    
    NSAttributedString *BigText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li.",(long)l_1] attributes:BigAttributes];
    NSAttributedString *SmallText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li",(long)l_2] attributes:SmallAttributes];
    
    NSMutableAttributedString *FinalAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:BigText];
    [FinalAttributedString appendAttributedString:SmallText];
    
    BtnTime.attributedText = FinalAttributedString;
    
    
    ////////
    //[BtnTime setText:[NSString stringWithFormat:@"%1.1f", m_Time]];
    if(m_Time == 0)
    {
        [m_TimerEnd invalidate];
        m_TimerEnd = nil;
        [self GameOver];
    }
    
}

- (void)FreshGame
{
    m_Level = 0;
    //m_Score = 0;
    m_Time = 15;
    m_Error = 0;
    [BtnScore setText:[NSString stringWithFormat:@"%li", (long)m_Level]];
    [BtnError setText:[NSString stringWithFormat:@"%li", (long)m_Error]];
    [BtnTime setTextColor:[UIColor greenColor]];
    [BtnTime setText:[NSString stringWithFormat:@"%li", (long)m_Time]];
    
}

- (void)GameOver
{
    [[SoundController GetSingleton] PlaySoundCongratulation];
    
    if (m_TimerEnd != nil) {
        [m_TimerEnd invalidate];
        m_TimerEnd = nil;
    }
    
    if(m_TimerStart != nil)
    {
        [m_TimerStart invalidate];
        m_TimerStart = nil;
    }
    
    [[Configuration GetSingleton] WriteScore:m_Level];
    [[Configuration GetSingleton] WriteBestScore:m_Level];
    [[Configuration GetSingleton] WriteNextTimePlay];
    if(([[Configuration GetSingleton] GetTimePlay] % 2) == 0)
    {
        [[GADMasterViewController GetSingleton] GetInterstitialAds];
    }
    
    [self FreshGame];
    m_State = GAMEOVER;
    [self performSegueWithIdentifier:@"segue2GameOver" sender:self];
    
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
}

- (IBAction)GameCenterClick:(id)sender
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

- (IBAction)RateClick:(id)sender
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
#endif
    
}

- (IBAction)HelpClick:(id)sender {
    [[SoundController GetSingleton] PlayClickButton];
    if (m_TimerStart != nil)
    {
        [m_TimerStart invalidate];
        m_TimerStart = nil;
    }
    
    if (m_TimerEnd != nil) {
        [m_TimerEnd invalidate];
        m_TimerEnd = nil;
    }
}

- (IBAction)SpeakerClick:(id)sender
{
    
    [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [self ShowSpeaker];
    
}

- (void) ShowSpeaker
{
    
    if ([[SoundController GetSingleton] GetMute])
    {
        //NSLog(@"Mute");
        [BtnSpeaker setImage:[UIImage imageNamed:@"btn_mute.png"] forState: UIControlStateNormal];
    }
    else
    {
        //NSLog(@"UnMute");
        [BtnSpeaker setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
}


@end
