//
//  AboutViewController.m
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/18/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//


@import GoogleMobileAds;

#import "AboutViewController.h"
#import "SoundController.h"
#import "GADMasterViewController.h"
#import "ViewController.h"


@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTitle;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonHome;

@property (weak, nonatomic) IBOutlet UITextView *mUITextView;


@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelCopyright;
@end

@implementation AboutViewController
@synthesize m_UIViewHeader, m_UILabelTitle, m_UILabelCopyright, m_UIButtonHome, m_UIViewFooter, mUITextView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [[GADMasterViewController singleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
}


-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //1 bacground
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:238.0/255.0 blue:169.0/255.0 alpha:1]];
    //[self.view setBackgroundColor:[UIColor darkGrayColor]];
    //2. Header
    
    // home
    CGRect frm = m_UIButtonHome.frame;
    frm.size.width = W_ICON * W;
    frm.size.height = frm.size.width;
    frm.origin.x =  1.0/4 * frm.size.width;
    frm.origin.y = 1.0/4 * frm.size.height;
    m_UIButtonHome.frame =frm;
    
    // header
    frm = m_UIViewHeader.frame;
    frm.size.width = W;
    frm.size.height = 3.0/2 * m_UIButtonHome.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIViewHeader.frame = frm;
    
    //title
    frm = m_UIViewHeader.frame;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTitle.frame = frm;
    
    
    //3 mUITextView
    frm = mUITextView.frame;
    frm.size.width = W - m_UIButtonHome.frame.size.width;
    frm.size.height = H - 1.0/6 * H - m_UIViewHeader.frame.size.height - 1.0/2 * m_UIButtonHome.frame.size.height;
    frm.origin.x = 1.0/2 * m_UIButtonHome.frame.size.width;
    frm.origin.y =m_UIViewHeader.frame.origin.y + m_UIViewHeader.frame.size.height +  1.0/2 * m_UIButtonHome.frame.size.height;
    mUITextView.frame = frm;
    [mUITextView setEditable:FALSE];
    
    //5 Footer
    frm = m_UIViewFooter.frame;
    frm.size.width = W;
    frm.size.height = 50;
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    m_UIViewFooter.frame = frm;
    
    //Copyrith
    frm.size.height =  m_UIViewFooter.frame.size.height * 1.0/2;
    frm.origin.x = 0;
    frm.origin.y =  m_UIViewFooter.frame.size.height * 1.0/4;
    m_UILabelCopyright.frame = frm;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)HomeClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

/*
- (IBAction)RemoveAdsClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}
- (IBAction)RestoreClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}
- (IBAction)m_MoreApp:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    NSString *urlString = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",YOUR_APP_ID];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    
}*/

- (void)SetArrayNumber: (NSMutableArray*) p_array
{
    m_Array100Number = [[NSMutableArray alloc] init];
    m_Array100Number = p_array;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"SegueHome"])
    {
        ViewController *MyView = (ViewController*)[segue destinationViewController];
        [MyView SetArrayNumber:m_Array100Number];
        [MyView SetStateGame:BACKVIEW];
    }
}


@end
