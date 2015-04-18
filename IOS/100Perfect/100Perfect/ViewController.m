//
//  ViewController.m
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/17/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "ViewController.h"
#import "SoundController.h"
#import "Define.h"

@interface ViewController ()
{
    NSMutableArray *m_Array100Number;
    NSInteger m_State;
    NSInteger m_CurrentNumber;
}
@property (weak, nonatomic) IBOutlet UIView *View100Number;
@property (weak, nonatomic) IBOutlet UIView *ViewButtons;
@property (weak, nonatomic) IBOutlet UIView *ViewFooter;
@property (weak, nonatomic) IBOutlet UIButton *BtnSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *BtnAbout;

@property (weak, nonatomic) IBOutlet UILabel *LblCopyright;

@end

@implementation ViewController
@synthesize View100Number, ViewButtons, ViewFooter,BtnAbout, BtnSpeaker, LblCopyright;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [self ShowSpeaker];
    [self Init100Number];
    
    m_State = PREPAREPLAY;
    m_CurrentNumber = -1;
    m_Array100Number = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //1. background
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    //2 100number
    CGRect frm = View100Number.frame;
    frm.size.width = W;
    frm.size.height = frm.size.width;
    frm.origin.x = 0;
    frm.origin.y = 0;
    View100Number.frame = frm;
    
    //3 Footer
    frm = ViewFooter.frame;
    frm.size.width = W;
    frm.size.height = H_FOOTER * H;
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    ViewFooter.frame = frm;
    
    //Copyrith
    frm.size.height =  H_FOOTER * H * 1.0/2;
    frm.origin.x = 0;
    frm.origin.y =  H_FOOTER * H * 1.0/2;
    LblCopyright.frame = frm;
    
    //4 buttons
    frm = ViewButtons.frame;
    frm.size.width = W;
    frm.size.height = H - View100Number.frame.size.height - ViewFooter.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = View100Number.frame.size.height;
    ViewButtons.frame = frm;
    
    // About
    frm = BtnAbout.frame;
    frm.size.width = W_ICON* W;
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/4 * frm.size.width;
    frm.origin.y = 1.0/2 * (ViewButtons.frame.size.height  - frm.size.height);
    BtnAbout.frame =frm;
    
    //Speaker
    frm = BtnAbout.frame;
    frm.origin.x = ViewButtons.frame.size.width - frm.size.width - 1.0/4 * frm.size.width;
    BtnSpeaker.frame = frm;
    
}

- (void)Init100Number
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/20 + 10);
    CGFloat h = w;

    for (NSUInteger i=0; i < 100; i++)
    {
        CGFloat x = (i % 10) * (1.0/ 20 + 1) * w;
        CGFloat y = (i / 10) * (1.0/20 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        MyNumber.frame = CGRectMake(x, y, w, h);
        MyNumber.tag = i;
        MyNumber.titleLabel.font = [UIFont systemFontOfSize:13 weight:5];
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [MyNumber setBackgroundColor:[UIColor darkGrayColor]];
        MyNumber.layer.cornerRadius = 5;
        
        //[MyNumber setTitleColor:[UIColor colorWithRed:131.0/255.0 green:104.0/255.0 blue:175.0/255.0 alpha:1] forState:UIControlStateNormal];
        //[MyNumber setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[MyNumber setTitle:[NSString stringWithFormat:@"%li", (long)(MyNumber.tag) ] forState:UIControlStateNormal];
        //MyNumber.alpha = 0.8;
        //[MyNumber setBackgroundImage:nil forState:UIControlStateNormal];
        
        [View100Number addSubview:MyNumber];
        [m_Array100Number addObject:MyNumber];
    }
}


- (void)NumberClick: (UIButton*)sender
{
   if(m_State == PREPAREPLAY)
       m_State = PLAYING;
    
    if(sender.tag == -1)
        return;
    

    NSInteger x = sender.tag % 10;
    NSInteger y = sender.tag / 10;
    
    
    printf("x: %li y: %li\n", x, y);
    /*
    
    if (sender.tag == (m_CurrentNumber + 1))
    {
        [[SoundController GetSingleton] PlaySoundCorrect];
        m_CurrentNumber += 1;
        sender.alpha = 0.8;
        [sender setBackgroundImage:[UIImage imageNamed:@"bg_circle.png"] forState:UIControlStateNormal];
        
        if (m_CurrentNumber == 100)
        {
            [self GameWin];
        }
    }
    else
    {
        NSLog(@"Press button: %li", (long)sender.tag);
        [sender setBackgroundColor:[UIColor redColor]];
        sender.alpha = 0.8;
        [self GameOver];
    }*/
    
    
}


- (void) ShowSpeaker
{
    
    if ([[SoundController GetSingleton] GetMute])
    {
        //NSLog(@"Mute");
        [BtnSpeaker setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
    else
    {
        //NSLog(@"UnMute");
        [BtnSpeaker setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SpeakerClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [self ShowSpeaker];
}
- (IBAction)AboutClick:(id)sender
{
     [[SoundController GetSingleton] PlayClickButton];
}

@end
