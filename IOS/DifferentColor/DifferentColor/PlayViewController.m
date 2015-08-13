//
//  ViewController.m
//  DifferentColor
//
//  Created by Nguyễn Thế Bình on 8/11/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "PlayViewController.h"
#import "SoundController.h"
#import "Define.h"


@interface PlayViewController ()
{
    NSMutableArray *m_Array100Number;
    NSInteger m_Level;
}
@property (weak, nonatomic) IBOutlet UIView *ViewBody;
@property (weak, nonatomic) IBOutlet UIView *ViewButtons;
@property (weak, nonatomic) IBOutlet UIView *ViewFooter;
@property (weak, nonatomic) IBOutlet UIButton *BtnSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *BtnShare;
@property (weak, nonatomic) IBOutlet UIButton *BtnRate;
@property (weak, nonatomic) IBOutlet UIButton *BtnGameCenter;


//Header
@property (weak, nonatomic) IBOutlet UIView *ViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *LblTitle;
@property (weak, nonatomic) IBOutlet UILabel *LblSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *LblScore;
@property (weak, nonatomic) IBOutlet UIButton *BtnScore;
@property (weak, nonatomic) IBOutlet UILabel *LblError;
@property (weak, nonatomic) IBOutlet UIButton *BtnError;
@property (weak, nonatomic) IBOutlet UILabel *LblTime;
@property (weak, nonatomic) IBOutlet UIButton *BtnTime;
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
    m_Level = 0;
    m_Array100Number = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self CalculateView];
    [self ShowSpeaker];
    
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
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //
    //Background
    //
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    //
    // Header View
    //
    CGRect frm;
    if(IS_IPHONE_5)
    {
        NSLog(@"Thi is IPHONE 5");
        frm.size.width = SCREEN_WIDTH - 10;
        frm.size.height = 120;
    }
    else{
        NSLog(@"Thi is not IPHONE 5");
        frm.size.width = SCREEN_WIDTH - 10;
        frm.size.height = 120;
    }
    
    frm.origin.x = 1.0/2 * (SCREEN_WIDTH - frm.size.width);
    frm.origin.y = 0;
    ViewHeader.frame = frm;
    
    //title
    frm.size.width = 5.0/8 * ViewHeader.frame.size.width;
    frm.size.height = 1.0/4 * ViewHeader.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    LblTitle.frame = frm;
    
    //subtitile
    frm = LblTitle.frame;
    frm.origin.x = 0;
    frm.origin.y = LblTitle.frame.origin.y + LblTitle.frame.size.height;
    LblSubTitle.frame = frm;
    
    
    //BtnTime
    frm.size.width = 2 * (LblTitle.frame.size.width - ViewHeader.frame.size.width * 1.0/2);
    frm.size.height = LblTitle.frame.size.height;
    frm.origin.x = 1.0/2 *(ViewHeader.frame.size.width - frm.size.width);
    frm.origin.y = 3.0/4 * ViewHeader.frame.size.height;
    BtnTime.frame = frm;
    
    //LblTime
    frm = BtnTime.frame;
    frm.origin.y = 1.0/2 * ViewHeader.frame.size.height;
    LblTime.frame = frm;
    
    //BtnHelp
    frm = BtnTime.frame;
    frm.origin.x = 0;
    
    //LblError
    frm = LblTime.frame;
    frm.origin.x = ViewHeader.frame.size.width - frm.size.width ;
    LblError.frame = frm;
    
    //BtnError
    frm = BtnTime.frame;
    frm.origin.x = LblError.frame.origin.x;
    BtnError.frame = frm;
    
    //BtnHelp
    frm = BtnTime.frame;
    frm.origin.x = 0;
    BtnHelp.frame = frm;
    
    
    //LblScore
    frm = LblError.frame;
    frm.origin.y = 0;
    LblScore.frame = frm;
    
    //BtnSocre
    frm = BtnError.frame;
    frm.origin.y = LblScore.frame.origin.y + LblError.frame.size.height;
    BtnScore.frame = frm;
    

    //Body
    frm = ViewBody.frame;
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = frm.size.width;
    frm.origin.x = 0;
    frm.origin.y = ViewHeader.frame.origin.y + ViewHeader.frame.size.height;
    ViewBody.frame = frm;
    [ViewBody setBackgroundColor:[UIColor clearColor]];
    
    //3 Footer
    frm = ViewFooter.frame;
    frm.size.width = W;
    frm.size.height = 50;
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    ViewFooter.frame = frm;
    
    //
    //Controller Button
    //
    frm = ViewButtons.frame;
    frm.size.width = W;
    frm.size.height = H - ViewBody.frame.size.height - ViewBody.frame.origin.y - ViewFooter.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = ViewBody.frame.size.height + ViewBody.frame.origin.y;
    ViewButtons.frame = frm;
    
    CGFloat l_w = 50;
    CGFloat l_delta = 1.0/5*(SCREEN_WIDTH - 4 * l_w);
    
    //Rate
    frm.size.width = l_w;
    frm.size.height = frm.size.width;
    frm.origin.x = l_delta;
    frm.origin.y = 1.0/2 * (ViewButtons.frame.size.height - frm.size.height);
    _BtnRate.frame = frm;
    
    //Facebook
    frm = _BtnRate.frame;
    frm.origin.x = frm.origin.x + frm.size.width + l_delta;
    _BtnShare.frame = frm;
    
    //GameCenter
    frm = _BtnShare.frame;
    frm.origin.x = frm.origin.x + frm.size.width + l_delta;
    BtnGameCenter.frame = frm;
    
    //Speaker
    frm = BtnGameCenter.frame;
    frm.origin.x = frm.origin.x + frm.size.width + l_delta;
    BtnSpeaker.frame = frm;
    
}

- (void)NextLevel
{
    m_Level++;
    NSInteger l_number_of_box = 0;
    NSInteger l_numberbox_on_row = 0;
    if (m_Level <= 1)
    {
        NSLog(@"Number box on row: %li", (long)l_numberbox_on_row);
        l_number_of_box = 4;
        l_numberbox_on_row = 2;
        
    }else if(m_Level <= 3)
    {
        l_number_of_box = 9;
        l_numberbox_on_row = 3;
    }else if(m_Level <= 7)
    {
        l_number_of_box = 16;
        l_numberbox_on_row = 4;
    }else if(m_Level <= 12)
    {
        l_number_of_box = 25;
        l_numberbox_on_row = 5;
    }else if(m_Level > 12)
    {
        l_number_of_box = 36;
        l_numberbox_on_row = 6;
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

    CGFloat W_SCREEN = [UIScreen mainScreen].bounds.size.width;
    CGFloat W_SPACE = W_SCREEN / 60;
    CGFloat W_BOX = (W_SCREEN - W_SPACE *(l_numberbox_on_row + 1)) / l_numberbox_on_row;
    
    for (NSUInteger i= 0; i < l_number_of_box; i++)
    {
        NSInteger l_column = i % l_numberbox_on_row;
        NSInteger l_row = i / l_numberbox_on_row;
        CGFloat x = (l_column + 1) * W_SPACE + l_column * W_BOX;
        CGFloat y = (l_row + 1) * W_SPACE + l_row * W_BOX;
        
        UIButton *MyNumber = [[UIButton alloc] init];
        MyNumber.frame = CGRectMake(x, y, W_BOX, W_BOX);
        MyNumber.tag = i;
        //[MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [MyNumber setBackgroundColor:[UIColor darkGrayColor]];
        MyNumber.layer.cornerRadius = 5;
        
        [ViewBody addSubview:MyNumber];
        [m_Array100Number addObject:MyNumber];
    };

    
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
- (IBAction)ReplayClick:(id)sender
{
    [self NextLevel];
}

@end
