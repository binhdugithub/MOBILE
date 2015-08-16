//
//  PlayViewController.m
//  DoDanGian
//
//  Created by Binh Du  on 4/22/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import "PlayViewController.h"
#import <Social/Social.h>
#import "SoundController.h"
#import "GADMasterViewController.h"
#import "DBManager.h"
#import "Define.h"


@interface PlayViewController ()
{
    NSInteger m_Level;
    NSInteger m_Score;
    NSString *m_Question;
    NSString *m_What;
    NSString *m_EKey;
    NSString *m_EKeyShort;
    NSString *m_VKey;
    NSString *m_Suggestion;
    NSMutableArray *m_ArrayAnswerButton;
    NSMutableArray *m_ArraySuggestionButton;
    NSArray *m_ArrayAllQuestion;
    
    NSTimer *m_TimerThinking;
    
    NSInteger m_CountPlay;
}

@property (weak, nonatomic) IBOutlet UIView *VHeader;
@property (weak, nonatomic) IBOutlet UIButton *BtnBack;
@property (weak, nonatomic) IBOutlet UILabel  *LblLevel;
@property (weak, nonatomic) IBOutlet UIButton *BtnCoint;

@property (weak, nonatomic) IBOutlet UIView *VQuestion;
@property (weak, nonatomic) IBOutlet UITextView *TVQuestion;
@property (weak, nonatomic) IBOutlet UIImageView *IVThinking;
@property (weak, nonatomic) IBOutlet UIImageView *IVQuestionFooter;

@property (weak, nonatomic) IBOutlet UIView *VAnswer;
//@property (weak, nonatomic) IBOutlet UIView *V3Line;
@property (weak, nonatomic) IBOutlet UIButton *BtnSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *BtnClear;
@property (weak, nonatomic) IBOutlet UIButton *BtnShare;
@property (weak, nonatomic) IBOutlet UIButton *BtnAsk;
@property (weak, nonatomic) IBOutlet UIImageView *IVWrong;

@property (weak, nonatomic) IBOutlet UIView *VSuggestion;

@property (weak, nonatomic) IBOutlet UIView *VFooter;
@property (weak, nonatomic) IBOutlet UILabel *LblCopyright;


@property (weak, nonatomic) IBOutlet UIView *VCongratulation;
@property (weak, nonatomic) IBOutlet UIView *VCgrHeader;
@property (weak, nonatomic) IBOutlet UIView *VCgrBody;
@property (weak, nonatomic) IBOutlet UIButton *BtnVcgNext;
@property (weak, nonatomic) IBOutlet UILabel *LblExactly;
@property (weak, nonatomic) IBOutlet UILabel *LblAddScore;
@property (weak, nonatomic) IBOutlet UILabel *LblAnswer;


@end

@implementation PlayViewController
@synthesize VAnswer,BtnAsk, BtnBack, BtnClear, BtnCoint, BtnShare, BtnSpeaker,BtnVcgNext,VCgrBody,VCgrHeader,VCongratulation,VFooter,VHeader,VQuestion,VSuggestion, LblAddScore, LblAnswer, LblCopyright, LblExactly, LblLevel;
@synthesize TVQuestion;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [self ShowSpeaker];
    [[GADMasterViewController singleton]resetAdBannerView:self AtFrame:VFooter.frame];
    m_CountPlay = 0;
}


- (void)viewWillAppear:(BOOL)animated
{
    m_Score = [[Configuration GetSingleton] GetScore];
    m_Level = [[Configuration GetSingleton] GetLevel];
    
   // NSString *l_level = [NSString stringWithFormat:@"CÂU ĐỐ: %li", (long)m_Level];
    //LblLevel.text = l_level;
    //[BtnCoint setTitle:[NSString stringWithFormat:@"%li", (long)m_Score] forState:UIControlStateNormal];
    
    [self LoadCauDo];
    [self NextQuestion];
    [self ResetContent];
    
     NSLog(@"Level:  %li and Ruby: %li", (long)[[Configuration GetSingleton] GetLevel], (long)[[Configuration GetSingleton] GetScore]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)LoadCauDo
{
    [[DBManager GetSingletone] SetDatabaseFilename:@"/DoDanGian.sqlite"];
    NSString *query = @"select * from CauDo";
    m_ArrayAllQuestion = [[NSArray alloc] initWithArray:[[DBManager GetSingletone] loadDataFromDB:query]];
    NSLog(@"How many sentense: %li", (long)m_ArrayAllQuestion.count);
  
}


- (void)NextQuestion
{
    if ([[Configuration GetSingleton] GetLevel] > m_ArrayAllQuestion.count)
    {
        NSLog(@"Vui long cap nhat ung dung: %li", (long)m_Level);
        
        NSString *title = @"ĐANG CẬP NHẬT" ;
        NSString *msg = @"Hiện tại game đang cập nhật các câu hỏi mới hoặc bạn có thể download phiên bản mới hơn !" ;
        NSString *titleCancel = @"THOÁT";
        
        if([[[UIDevice currentDevice] systemVersion] floatValue]<8.0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:nil ,nil];
            //alert.tag = 1000;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:nil ,nil];
            alert.tag = 1000;
            [alert show];
        }
        
        m_Question = @"Game đang cập nhật câu hỏi mới";
        m_EKey = @"";
        m_EKeyShort =@"";
        m_VKey = @"";
        m_What = @"  ";
        
        return;
    }
    else
    {
        NSArray *Question = [[NSArray alloc] initWithArray:m_ArrayAllQuestion[m_Level - 1]];
        
        NSInteger indexOfQuestion = [[DBManager GetSingletone].arrColumnNames indexOfObject:@"Question"];
        NSInteger indexOfWhat = [[DBManager GetSingletone].arrColumnNames indexOfObject:@"What"];
        NSInteger indexOfEKey = [[DBManager GetSingletone].arrColumnNames indexOfObject:@"EKey"];
        NSInteger indexVKey = [[DBManager GetSingletone].arrColumnNames indexOfObject:@"VKey"];
        
        
        NSMutableString *l_Question = [NSMutableString stringWithFormat:@"%@",[Question objectAtIndex:indexOfQuestion]];
        m_Question = [l_Question stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        // m_Question = [m_Question uppercaseString];
        
        NSMutableString *l_What = [NSMutableString stringWithFormat:@"%@",[Question objectAtIndex:indexOfWhat]];
        m_What = [l_What stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableString *l_EKey = [NSMutableString stringWithFormat:@"%@",[Question objectAtIndex:indexOfEKey]];
        m_EKey = [l_EKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        m_EKey = [m_EKey uppercaseString];
        
        NSMutableString *MuteEKey = [NSMutableString stringWithFormat:@"%@", @""];
        for (int i = 0; i < m_EKey.length; i++)
        {
            char ch = [m_EKey characterAtIndex:i];
            if (ch != ' ')
            {
                [MuteEKey appendFormat:@"%c", ch];
            }
        }
        
        m_EKeyShort = [NSString stringWithFormat:@"%@", MuteEKey];
        
        NSMutableString *l_VKey = [NSMutableString stringWithFormat:@"%@",[Question objectAtIndex:indexVKey]];
        m_VKey = [l_VKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        m_VKey = [m_VKey uppercaseString];
        
        NSMutableString *l_Suggestion = [NSMutableString stringWithFormat:@"%@", [self createEnSuggestResult:m_EKeyShort]];
        m_Suggestion = [l_Suggestion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        NSLog(@"Question: %@ EKey: %@ VKey: %@ Suggestion: %@", m_Question, m_EKey, m_VKey, m_Suggestion);
        
    }
    
}

- (void)ResetContent
{
    NSString *l_level = [NSString stringWithFormat:@"CÂU ĐỐ: %li", (long)m_Level];
    LblLevel.text = l_level;
    [BtnCoint setTitle:[NSString stringWithFormat:@"%li", (long)m_Score] forState:UIControlStateNormal];
    
    NSString *l_question = [NSString stringWithFormat:@"%@\n\n->> %@ ?", m_Question, m_What];
    TVQuestion.text = l_question;
    [TVQuestion setTextAlignment:NSTextAlignmentCenter];
    if(IS_IPAD)
        TVQuestion.font = [UIFont systemFontOfSize:25 weight:0];
    else
        TVQuestion.font = [UIFont systemFontOfSize:15 weight:0];
    TVQuestion.textColor = [UIColor blackColor];
    
    
    [self ResetArrayAnswerButton];
    [self ResetArraySuggestionButton];
    
    m_TimerThinking = [NSTimer scheduledTimerWithTimeInterval:5.0
                                               target:self
                                             selector:@selector(RefreshEmotionThinking:)
                                             userInfo:nil
                                              repeats:YES];
}


- (void)ResetArrayAnswerButton
{
   
    if(m_ArrayAnswerButton != nil)
    {
        for (UIButton *MyButton in m_ArrayAnswerButton) {
            
            //[m_ArrayAnswerButton removeObject:MyButton];
            [MyButton removeFromSuperview];
        }
        
        [m_ArrayAnswerButton removeAllObjects];
        
    }
    else
        m_ArrayAnswerButton = [[NSMutableArray alloc] init];
    
    CGFloat W = [[UIScreen mainScreen] bounds].size.width;
    CGFloat w = W * 1.0 / ( 10 + 11.0/ 4);
    CGFloat start_x = 0.0;
    
    int k = 0;
    int line = 0;
    //m_EKey = @"ABCD EFGG";
    
    for (int i = 0; i < m_EKey.length; i++)
    {
        char ch = [m_EKey characterAtIndex:i];
        if (ch == ' ' || i == m_EKey.length - 1)
        {
            NSString *Line = [m_EKey substringWithRange:NSMakeRange(k, i - k)];
            if (i == m_EKey.length - 1)
            {
                Line = [m_EKey substringWithRange:NSMakeRange(k, i + 1 - k)];
            }
            
            NSLog(@"Line: %@", Line);
            start_x = 1.0/2 * (VAnswer.frame.size.width - Line.length * w - (Line.length - 1) * 1.0/8 * w);
            
            for (int j = 0; j < Line.length; j++)
            {
                UIButton *AnswerButton = [[UIButton alloc] init];
                CGRect frm = AnswerButton.frame;
                frm.size.width = w;
                frm.size.height = w;
                frm.origin.x = start_x + (j + 1) * 1.0/8 * w + j * w - 500;
                //frm.origin.x = 0;
                frm.origin.y = 1.0/ 4 * w + line * (1 + 1.0/4) * w;
                AnswerButton.frame = frm;
                AnswerButton.layer.cornerRadius = 3;
                AnswerButton.backgroundColor = [UIColor colorWithRed:85.0/255 green:85.0/255 blue:85.0/255 alpha:0.8];
                [AnswerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
                
                if(IS_IPAD)
                    AnswerButton.titleLabel.font = [UIFont systemFontOfSize:25 weight:1];
                else
                    AnswerButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
                
                [AnswerButton addTarget:self action:@selector(AnswerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                AnswerButton.tag= -1;
                
                [m_ArrayAnswerButton addObject:AnswerButton];
                [VAnswer addSubview:AnswerButton];
            }
            
            k = i + 1;
            line ++;
        }
    }
    
    NSNumber *l_number = [NSNumber numberWithFloat:start_x];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(StartMotionAnswerButton:)
                                   userInfo:l_number
                                    repeats:NO];
}


- (void) StartMotionAnswerButton:(NSTimer*)p_timer
{
    [p_timer invalidate];
    p_timer = nil;

    for (UIButton *l_answer in m_ArrayAnswerButton)
    {
        CGRect frm = l_answer.frame;
        //frm.origin.x = start_x + (i + 1) * 1.0/8 * w + i * w;
        frm.origin.x += 500;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        l_answer.frame = frm;
        [UIView commitAnimations];
    }
    
}

- (void)ResetArraySuggestionButton
{
    for(int i = 0 ; i < NUM_RANDOM_BUTTON; i++)
    {
        UIButton *l_SuggestButton= m_ArraySuggestionButton[i];
        NSString *title = [NSString stringWithFormat:@"%c", [m_Suggestion characterAtIndex:i]];
        [l_SuggestButton setTitle:title forState:UIControlStateNormal];
        [l_SuggestButton addTarget:self action:@selector(SuggestionButtonClick:)forControlEvents:UIControlEventTouchUpInside];
        l_SuggestButton.tag= i + 1;
        l_SuggestButton.hidden = FALSE;
        
        CGRect frm = l_SuggestButton.frame;
        frm.origin.x = ((i%9) + 1) * 1.0/8 * frm.size.width + (i%9) * frm.size.width;
        frm.origin.y = 1.0/8 * frm.size.height + (i / 9) * ( frm.size.height + 1.0/8 * frm.size.height);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        l_SuggestButton.frame = frm;
        [UIView commitAnimations];
        
    }
}
                 
- (void)AnswerButtonClick: (UIButton *)sender
{
    if (sender.tag <= 0) {
        return;
    }
    [[SoundController GetSingleton] PlayClickButton];
    for(UIButton *MyButton in m_ArraySuggestionButton)
    {
        if(MyButton.tag == sender.tag)
        {
            //[MyButton setTitle:[sender titleLabel].text forState:UIControlStateNormal];
            [MyButton setHidden:FALSE] ;
           [sender setTitle:@"" forState:UIControlStateNormal];
            sender.tag = -1;
            
            break;
            
        }
    }
                     
};

- (void)SuggestionButtonClick: (UIButton*)sender
{
    if (m_EKey.length <= 0) {
        return;
    }
    
    [[SoundController GetSingleton] PlaySoundCorrect];
    for(UIButton *MyButton in m_ArrayAnswerButton)
    {
        if(MyButton.tag == -1)
        {
            //[MyButton setTitle:[sender titleLabel].text forState:UIControlStateNormal];
            [MyButton setTitle:[sender titleForState:UIControlStateNormal] forState:UIControlStateNormal] ;
            MyButton.tag = sender.tag;
            
            //[sender setTitle:@"" forState:UIControlStateNormal];
            [sender setHidden:TRUE] ;
            
            break;
        }
    }
    
    BOOL isFillAll = TRUE ;
    for (UIButton *button in m_ArrayAnswerButton)
    {
        if (button.tag == -1)
        {
            isFillAll = FALSE ;
            //return isFillAll;
        }
    }
    
    //check result
    if (isFillAll == TRUE)
        [self CheckResult];
    
    
    
}


- (void) CheckResult
{
    NSMutableString *myFillResult = [[NSMutableString alloc] initWithString:@""];
    
    for (UIButton *button in m_ArrayAnswerButton)
    {
        [myFillResult appendString:[button titleForState:UIControlStateNormal]] ;
        
    }
    
    if([myFillResult compare:m_EKeyShort] == 0)
    {
        //[self performSegueWithIdentifier:@"Segue2ResultView" sender:nil] ;
        //NSLog(@"Chuc mung ban !!!");
        
        [[SoundController GetSingleton] PlaySoundCongratulation];
        [m_TimerThinking invalidate];
        _IVThinking.alpha = 0;
        VCongratulation.hidden = FALSE;
        [LblAnswer setTextColor:[UIColor darkGrayColor]];
        LblAnswer.text = m_VKey;
        
        m_Level += 1;
        m_Score += RUBY_FOR_NEXT_LEVEL;
        [self SaveConfig];
        
        //NSString *l_level = [NSString stringWithFormat:@"CÂU ĐỐ: %li", (long)m_Level];
        //LblLevel.text = l_level;
        
        [BtnCoint setTitle:[NSString stringWithFormat:@"%li", (long)m_Score] forState:UIControlStateNormal];
        
    }
    else
    {
        NSString *message = @"Bạn trả lời sai rồi ^^";
        NSLog(@"%@", message);
        
        [[SoundController GetSingleton] PlaySoundGameOver];

        _IVWrong.hidden = FALSE;
        for (UIButton *MyButton in m_ArrayAnswerButton)
        {
            [MyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        NSInteger duration = 2;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            _IVWrong.hidden = TRUE;
            for (UIButton *MyButton in m_ArrayAnswerButton)
            {
                if (MyButton.tag != 0) {
                    [MyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                else if(MyButton.tag == 0)
                {
                    [MyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                }
            }
            [UIView commitAnimations];
            
        });
        
    }
    
}

- (IBAction)NextLevelClick:(id)sender
{
    
    [self NextQuestion];
    for(int i = 0 ; i < NUM_RANDOM_BUTTON; i++)
    {
        UIButton *l_SuggestButton= m_ArraySuggestionButton[i];
        CGRect frm = l_SuggestButton.frame;
        frm.origin.x = ((i%9) + 1) * 1.0/8 * frm.size.width + (i%9) * frm.size.width;
        frm.origin.y = -(VQuestion.frame.origin.y + VQuestion.frame.size.height);
        
        l_SuggestButton.hidden = FALSE;
        l_SuggestButton.frame = frm;
    }
        
    [self ResetContent];
    VCongratulation.hidden = TRUE;
    
    if(m_CountPlay++ >= AMOD_INTERSTITIAL_TIMES_2_SHOW)
    {
        NSLog(@"Count Play 1:  %li", (long)m_CountPlay);
        m_CountPlay = 0;
        [[GADMasterViewController singleton] resetAdInterstitialView:self];
    }
}




-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //1. background
    [self.view setBackgroundColor:[UIColor colorWithRed:226/255.0 green:220/255.0 blue:186/255.0 alpha:1]];
    
    //3 Footer
    CGRect frm = VFooter.frame;
    frm.size.width = W;
    frm.size.height = 50;
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    [VFooter setBackgroundColor:[UIColor clearColor]];
    VFooter.frame = frm;
    
    //Copyrith
    frm.size.height =  VFooter.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y =  1.0/2 *( VFooter.frame.size.height - frm.size.height);
    LblCopyright.frame = frm;
    
    //3 _VSuggestion
    CGFloat BTN_W = W * 4.0/41;
    frm.size.width = BTN_W;
    frm.size.height = BTN_W;
    
    m_ArraySuggestionButton = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < NUM_RANDOM_BUTTON; i++)
    {
        UIButton *l_SuggestButton = [[UIButton alloc] init];
        frm.origin.x = ((i%9) + 1) * 1.0/8 * frm.size.width + (i%9) * frm.size.width;
        //frm.origin.y = 1.0/8 * frm.size.height + (i / 9) * ( frm.size.height + 1.0/8 * frm.size.height);
        //frm.origin.x = -100;
        frm.origin.y = -(VQuestion.frame.origin.y + VQuestion.frame.size.height);
        l_SuggestButton.frame = frm;
        l_SuggestButton.layer.cornerRadius = 5.0f;
        //MyButton.backgroundColor = [UIColor darkGrayColor];
        //MyButton.backgroundColor = [UIColor colorWithRed:95.0/255 green:111.0/255 blue:44.0/255 alpha:1];
        l_SuggestButton.backgroundColor = [UIColor colorWithRed:167.0/255 green:120.0/255 blue:38.0/255 alpha:1];
        
        if(IS_IPAD)
            l_SuggestButton.titleLabel.font = [UIFont systemFontOfSize:30 weight:1];
        else
            l_SuggestButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:1];
        
        [l_SuggestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        l_SuggestButton.tag = - 1;
        
        //MyButton.layer.borderWidth = 2.0;
        //MyButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        
        //[MyButton setTitle:@"A" forState:UIControlStateNormal];
        
        l_SuggestButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        l_SuggestButton.layer.shadowRadius = 5.0f;
        l_SuggestButton.layer.shadowOpacity = 1.0f;
        l_SuggestButton.layer.shadowOffset = CGSizeZero;
        
        [m_ArraySuggestionButton addObject:l_SuggestButton];
        [VSuggestion addSubview:l_SuggestButton];
    }
    
    
    frm = VFooter.frame;
    frm.size.width = W;
    frm.size.height = 2 * BTN_W + 3.0/8 * BTN_W;
    frm.origin.x = 0;
    frm.origin.y = H - VFooter.frame.size.height - frm.size.height - 1.0/4 * BTN_W;
    //if (H < 480)
        //frm.origin.y = H - VFooter.frame.size.height - frm.size.height;
    //[VSuggestion setBackgroundColor:[UIColor clearColor]];
    VSuggestion.frame = frm;
    
    //Speaker
    if(IS_IPHONE_4_OR_LESS || IS_IPAD)
    {
        frm.size.width =  BTN_W;
        frm.size.height = frm.size.width;
        frm.origin.x = 1.0/2 * (VSuggestion.frame.size.width - 4 * frm.size.width - 3* BTN_W);
        frm.origin.y = VSuggestion.frame.origin.y - frm.size.height - 10;
    }
    else
    {
        frm.size.width = 3.0/2 * BTN_W;
        frm.size.height = frm.size.width;
        frm.origin.x = 1.0/2 * (VSuggestion.frame.size.width - 4 * frm.size.width - 3* BTN_W);
        frm.origin.y = VSuggestion.frame.origin.y - 1.0/2 * frm.size.height - frm.size.height;
    }
    
    BtnSpeaker.frame = frm;
    
    //Clear
    frm = BtnSpeaker.frame;
    //frm.origin.y = sk_y * 2 + frm.size.height;
    frm.origin.x = frm.origin.x + frm.size.width + BTN_W;
    BtnClear.frame = frm;
    
    //facebook
    frm = BtnClear.frame;
    //frm.origin.x = VAnswer.frame.size.width - 1.0/4 * frm.size.width - frm.size.width;
    frm.origin.x = frm.origin.x + frm.size.width + BTN_W;
    BtnShare.frame = frm;
    
    //Ask
    frm= BtnShare.frame;
    //frm.origin.y = BtnClear.frame.origin.y;
    frm.origin.x = frm.origin.x + frm.size.width + BTN_W;
    BtnAsk.frame = frm;
    
    
    
    
    
    //5. VHeader
    frm = VHeader.frame;
    frm.size.width = W;
    frm.size.height = H_HEADER * H;
    frm.origin.x = 0;
    frm.origin.y = 0;
    VHeader.frame = frm;
    
    //Level
    [LblLevel setTextColor:[UIColor whiteColor]];
    [LblLevel setFont:[UIFont systemFontOfSize:16 weight:1.0f] ];
    frm = VHeader.frame;
    frm.size.width = 1.0/3 * VHeader.frame.size.width;
    frm.size.height = 1.0/2 * VHeader.frame.size.height;
    frm.origin.x = 1.0/2 * (VHeader.frame.size.width - frm.size.width);
    frm.origin.y = 1.0/2 * (VHeader.frame.size.height - frm.size.height);
    //frm.size.height = VHeader.frame.size.height + 1.0/20 * VHeader.frame.size.height;
    //frm.size.width = 1.03 * VHeader.frame.size.height;
    //frm.origin.x = 1.0/2 *( VHeader.frame.size.width - frm.size.width);
    //frm.origin.y = 1.0/2 * ( VHeader.frame.size.height - frm.size.height);
    LblLevel.textAlignment = NSTextAlignmentCenter;
    LblLevel.frame = frm;

    
    //Back
    frm.size.height = 1.0/2 * VHeader.frame.size.height;
    frm.size.width =  frm.size.height;
    frm.origin.x = 1.0/4 * frm.size.width;
    frm.origin.y = 1.0/2 * (VHeader.frame.size.height - frm.size.height);
    BtnBack.frame = frm;
    
    //coint
    frm.size.width = 1.0/4 * VHeader.frame.size.width;
    frm.size.height = 3.0/10 * frm.size.width;
    frm.origin.x = VHeader.frame.size.width - frm.size.width - 1.0/2* BtnBack.frame.size.width;
    frm.origin.y = 1.0/2 * (VHeader.frame.size.height - frm.size.height);
    BtnCoint.frame = frm;
    
    
    //VQuestion
    frm = VQuestion.frame;
    frm.size.width = W;
    frm.size.height = 1.0/3 * H;
    if (H > 480)
    {
        //frm.size.height = VAnswer.frame.origin.y - VHeader.frame.size.height - BtnSpeaker.frame.size.height - VHeader.frame.origin.y;
        //frm.size.height = 1.0/3 * H;
    }
    
    frm.origin.x = 0;
    frm.origin.y = VHeader.frame.origin.y + VHeader.frame.size.height;
    //VQuestion.backgroundColor = [UIColor colorWithRed:167.0/255 green:120.0/255 blue:38.0/255 alpha:0.8];
    [VQuestion setBackgroundColor: [UIColor colorWithRed:167.0/255 green:120.0/255 blue:38.0/255 alpha:0.5]];
    
    VQuestion.frame = frm;
    //VQuestion.alpha = 0.95;
    
    //Text Question
    frm = VQuestion.frame;
    frm.size.width = frm.size.width - 1.0/40 * frm.size.width;
    frm.size.height = frm.size.height  - 1.0/40 * frm.size.width;
    frm.origin.x = 1.0/2 * (VQuestion.frame.size.width - frm.size.width);
    frm.origin.y = 1.0/2 * (VQuestion.frame.size.height - frm.size.height);
    
    //TVQuestion.layer.borderWidth = 4.0;
    //TVQuestion.layer.masksToBounds = YES;
    //_TVQuestion.layer.borderColor = [[UIColor whiteColor] CGColor];
    TVQuestion.layer.cornerRadius = 5.0;
    //TVQuestion.backgroundColor = [UIColor colorWithRed:167.0/255 green:120.0/255 blue:38.0/255 alpha:1];
    TVQuestion.backgroundColor = [UIColor whiteColor];
    
    TVQuestion.frame = frm;

    //Emotion
    frm = BtnSpeaker.frame;
    //frm.size.width *= 1.5;
    //frm.size.height *=1.5;
    frm.origin.x = VQuestion.frame.size.width - 1.0/8 * frm.size.width - frm.size.width;
    frm.origin.y = VQuestion.frame.size.height - 1.0/8 * frm.size.height - frm.size.height;
    
    _IVThinking.frame = frm;
    
    //4 VAnswer
    BTN_W = W * 1.0 / ( 10 + 11.0/8);
    frm.size.width = W;
    frm.size.height = (3 + 4 * 1.0/8) * BTN_W;
    frm.origin.x = 0;
    frm.origin.y = VQuestion.frame.origin.y + VQuestion.frame.size.height;
    
    if (H > 480)
    {
        //frm.origin.y = VSuggestion.frame.origin.y - frm.size.height - 2 * BTN_W;
    }
    
    [VAnswer setBackgroundColor:[UIColor clearColor]];
    VAnswer.frame = frm;
    
    //Answer wrong
    //frm = _VAnswer.frame;
    frm = BtnShare.frame;
    //frm.size.width *= 1.5;
    frm.size.height = frm.size.width;
    frm.origin.x = VAnswer.frame.size.width -  frm.size.width;
    frm.origin.y = ( VAnswer.frame.size.height - frm.size.height);
    _IVWrong.frame = frm;
    _IVWrong.hidden = TRUE;
    
    //VQuestionFooter
    frm = VQuestion.frame;
    frm.size.width = W;
    frm.size.height = [UIScreen mainScreen].bounds.size.height - VQuestion.frame.size.height - VQuestion.frame.origin.y;
    frm.origin.x = 0;
    frm.origin.y =    VQuestion.frame.origin.y + VQuestion.frame.size.height ;
    _IVQuestionFooter.frame = frm;
    _IVQuestionFooter.alpha = 0.95;
    
    
    //7. View congratulation
    frm= VSuggestion.frame;
    //frm.size.width = frm.size.width - 1.0/ 10 * frm.size.width;
    frm.size.height = VSuggestion.frame.origin.y + VSuggestion.frame.size.height - VQuestion.frame.origin.y - VQuestion.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = VQuestion.frame.origin.y + VQuestion.frame.size.height;
    VCongratulation.frame = frm;
    //_VCongratulation.layer.cornerRadius = 10;
    VCongratulation.alpha = 0.95;
    //header
    frm =VCongratulation.frame;
    frm.size.height *= 1.0/4;
    frm.origin.x =  0;
    frm.origin.y = 0;
    VCgrHeader.frame = frm;
    //_VCgrHeader.layer.cornerRadius = 10;
    
    //Dap an
    frm = VCgrHeader.frame;
    frm.size.height *= 1.0/2;
    frm.origin.x = 0;
    frm.origin.y = 0;
    LblExactly.frame = frm;
    
    //Add score
    frm = VCgrHeader.frame;
    frm.size.height *= 1.0/2;
    frm.origin.x = 0;
    frm.origin.y = LblExactly.frame.size.height;
    LblAddScore.frame = frm;
    
    //Body
    frm = VCgrHeader.frame;
    frm.size.height = 1.0/2 * VCongratulation.frame.size.height;
    frm.origin.y = VCgrHeader.frame.origin.y + VCgrHeader.frame.size.height;
    VCgrBody.frame = frm;
    
    //Answer
    frm = VCgrBody.frame;
    frm.origin.x = 0;
    frm.origin.y = 0;
    LblAnswer.frame = frm;
    
    //Button
    frm = VCgrHeader.frame;
    //frm.size.height = 1.0/2 * frm.size.width;
    frm.size.width = frm.size.height * 2;
    frm.origin.x = 1.0/2 * (VCgrBody.frame.size.width - frm.size.width);
    frm.origin.y = VCgrBody.frame.origin.y + VCgrBody.frame.size.height;
    BtnVcgNext.frame = frm;
    //BtnVcgNext.layer.cornerRadius = 10;
    
    VCongratulation.hidden = TRUE;
    
}

- (void)RefreshEmotionThinking: (NSTimer*) p_timer
{
    [UIView beginAnimations:nil context:nil];
    
    
    if (_IVThinking.alpha == 1)
    {
        [UIView setAnimationDuration:2];
        _IVThinking.alpha = 0;
    }
    else
    {
        [UIView setAnimationDuration:0.5];
        _IVThinking.alpha = 1;
    }
    
    
    [UIView commitAnimations];
    
}


- (void) SaveConfig
{
    [[Configuration GetSingleton] WriteLevel:m_Level];
    [[Configuration GetSingleton] WriteScore: m_Score];
}


- (NSString*) createEnSuggestResult :(NSString*) enResult
{
    NSMutableString *str1 = [[NSMutableString alloc]initWithString:enResult];
    
    for (int i= 0 ; i < NUM_RANDOM_BUTTON - [enResult length] ; i++)
    {
        int k = arc4random() % [ALPHABETA length];
        char ch = [ALPHABETA characterAtIndex:k];
        [str1 appendFormat:@"%c", ch];
    }
    
    NSMutableString *str2 = [[NSMutableString alloc] init];
    while ([str1 length] > 0)
    {
        int i = arc4random() % [str1 length];
        NSRange range = NSMakeRange(i,1);
        NSString *sub = [str1 substringWithRange:range];
        [str2 appendString:sub];
        [str1 replaceOccurrencesOfString:sub withString:@"" options:nil range:range];
    }
    
    return str2;
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

- (IBAction)ClearClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    for(UIButton *MyButton in m_ArrayAnswerButton)
    {
        if (MyButton.tag > 0 )
        {
            MyButton.tag = -1;
            [MyButton setTitle:@"" forState:UIControlStateNormal];
        }
    }
    
    for (UIButton *MyButton in m_ArraySuggestionButton) {
        if (MyButton.tag == 0) {
            continue;
        }
        else{
            MyButton.hidden = FALSE;
        }
    }
    
}



- (IBAction)SuggestClick:(id)sender
{
    if (m_EKey.length <= 0) {
        return;
    }
    
    [[SoundController GetSingleton] PlayClickButton];
    if (m_Score >= RUBY_FOR_SUGGESTION_CHARACTER)
    {
        m_Score -= RUBY_FOR_SUGGESTION_CHARACTER;
        [BtnCoint setTitle:[NSString stringWithFormat:@"%li", (long)m_Score] forState:UIControlStateNormal];
        [self SaveConfig];
        
        
        for (int i= 0; i < m_ArrayAnswerButton.count; i++)
        {
            UIButton *MyButton = m_ArrayAnswerButton[i];
            if (MyButton.tag != 0)
            {
                NSString *title = [NSString stringWithFormat:@"%c",[m_EKeyShort characterAtIndex:i] ];
                [MyButton setTitle:title  forState:UIControlStateNormal];
                MyButton.tag = 0;
                [MyButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                
                for (UIButton *SuggestionButton in m_ArraySuggestionButton)
                {
                    if (SuggestionButton.tag == 0)
                        continue;
                    
                    if ([title compare:[SuggestionButton titleForState:UIControlStateNormal]] == 0)
                    {
                        SuggestionButton.hidden = TRUE;
                        SuggestionButton.tag = 0;
                        break;
                    }
                }
                
                break;
            }
        }
        
    }
    
    
    BOOL isFillAll = TRUE ;
    for (UIButton *button in m_ArrayAnswerButton)
    {
        if (button.tag == -1)
        {
            isFillAll = FALSE ;
            //return isFillAll;
        }
    }
    
    //check result
    if (isFillAll == TRUE)
        [self CheckResult];
    
    
}
- (IBAction)BackClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}



- (IBAction)ShareClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] PlayClickButton];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController
                                            composeViewControllerForServiceType:SLServiceTypeFacebook];
        //[fbSheet setInitialText:@"Giúp tôi với"];
        //NSString *l_url = [NSString stringWithFormat:@"%@%@",@"https://itunes.apple.com/app/id", YOUR_APP_ID];
        //[fbSheet addURL:[NSURL URLWithString:l_url]];
        [fbSheet addImage:[self TakeScreenshot]];
        
        [fbSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result)
            {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    m_Score += RUBY_FOR_SHARE;
                    [BtnCoint setTitle:[NSString stringWithFormat:@"%li", (long)m_Score] forState:UIControlStateNormal];
                    [self SaveConfig];
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else
    {
        NSString *title = @"No Facebook Account" ;
        NSString *msg = @"You can add or create a Facebook acount in Settings->Facebook" ;
        NSString *titleCancel = @"Cancel";
        NSString *titleSetting   = @"Setting";
        
        //BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
        //if (canOpenSettings) {
        if([[[UIDevice currentDevice] systemVersion] floatValue]<8.0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:titleSetting ,nil];
            alert.tag = 100;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:titleSetting ,nil];
            alert.tag = 100;
            [alert show];
        }
        
    }
    
}


- (UIImage*) TakeScreenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != /* DISABLES CODE */ (&UIGraphicsBeginImageContextWithOptions))
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    
    // Retrieve the screenshot image
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    //NSData *imageDataForEmail = UIImageJPEGRepresentation(imageForEmail, 1.0);
    
    return screenImage;
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 100 && buttonIndex == 1)
    {
        //code for opening settings app in iOS 8
        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
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
