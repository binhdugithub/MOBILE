
//
//  1PlayerViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "SinglePlayerViewController.h"
#import "SingleResultViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SoundController.h"

@interface SinglePlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UIView *m_UIView100Number;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonPlay;
@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;

@property (nonatomic, strong)NSMutableArray *m_Array100Number;
@property (nonatomic, assign)NSInteger m_CurrentNumber;
@property (nonatomic, assign)NSInteger  m_Sate;

@property (nonatomic, strong) SoundController *m_Sounder;
@end

@implementation SinglePlayerViewController
@synthesize m_UIButtonPlay, m_UIView100Number, m_UIViewFooter, m_UIViewHeader;
@synthesize m_Array100Number, m_CurrentNumber;
@synthesize m_Sate;
@synthesize m_Sounder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_Sounder = [[SoundController alloc] init];
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
        [MyNumber setBackgroundColor:[UIColor whiteColor]];
        MyNumber.alpha = 0.95;
        
        //[m_UIView100Number setBackgroundColor:[UIColor whiteColor]];
        [m_UIView100Number addSubview:MyNumber];
        
        [m_Array100Number addObject:MyNumber];
    }
}

- (void)ReArange100Number
{
    for (NSUInteger i = m_Array100Number.count-1; i > 0; i--)
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
        MyNumber.alpha = 0.95;
        
        i++;
    }
}

- (void)NumberClick: (UIButton*)sender
{
    if (sender.tag < m_CurrentNumber)
        return;
    
    switch (m_Sate)
    {
        case FIRSTWIEW:
        case BACKVIEW:
            return;
        case PREPAREPLAY:
            m_Sate = PLAYING;
            break;
        case PLAYING:
            m_Sate = PLAYING;
            break;
        default:
            return;
    }
    
    if (sender.tag == (m_CurrentNumber + 1))
    {
        m_CurrentNumber += 1;
        sender.alpha = 0.5;
        //[sender setBackgroundColor:[UIColor greenColor]];
    }
    else
    {
        [sender setBackgroundColor:[UIColor redColor]];
        sender.alpha = 0.5;
        [self GameOver];
    }

}




- (IBAction)HomeClick:(id)sender
{
    [m_Sounder PlayClick];
}

- (IBAction)PlayClick:(id)sender
{
    [m_Sounder PlayClick];
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
            //alert.tag = 1000;
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
        m_Sate = PREPAREPLAY;
        [self ReArange100Number];
    }
}

- (void)GameOver
{
    
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
}


@end
