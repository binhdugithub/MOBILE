
//
//  1PlayerViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "SinglePlayerViewController.h"

@interface SinglePlayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UIView *m_UIView100Number;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonPlay;
@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;

@property (nonatomic, strong)NSMutableArray *m_Array100Number;
@property (nonatomic, assign)NSUInteger m_CurrentNumber;
@property (nonatomic, assign)BOOL m_NeedRefreshGUI;
@end

@implementation SinglePlayerViewController
@synthesize m_UIButtonPlay, m_UIView100Number, m_UIViewFooter, m_UIViewHeader;
@synthesize m_Array100Number, m_CurrentNumber;
@synthesize m_NeedRefreshGUI;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Do dai cua mang: %i", m_Array100Number.count);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Init 100Button
    m_CurrentNumber = 1;
    m_Array100Number = [[NSMutableArray alloc] init];
    [self Init100Number];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
}

- (void)SetNeedRefreshGUI: (BOOL) p_true
{
    
}

- (void)Init100Number
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/8 + 10);
    CGFloat h = w;
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
        CGRect frm = m_UIView100Number.frame;
        frm.origin.x = 0;
        frm.size.width = [UIScreen mainScreen].bounds.size.width;
        frm.size.height = [UIScreen mainScreen].bounds.size.width;
       
        m_UIView100Number.frame = frm;
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
        
        i++;
    }
}

- (void)NumberClick: (UIButton*)sender
{
    if (sender.tag == m_CurrentNumber)
    {
        m_CurrentNumber += 1;
        [sender setBackgroundColor:[UIColor greenColor]];
    }
    else
    {
        [self GameOver];
    }

}


- (IBAction)PlayClick:(id)sender
{
    [self ReArange100Number];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
