//
//  1ResultViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//
#import <Social/Social.h>
#import "GameOverViewController.h"
#import "SinglePlayerViewController.h"
#import "StatisticsViewController.h"
#import "GADMasterViewController.h"
#import "SoundController.h"
#import "Configuration.h"
#include "Define.h"


@interface GameOverViewController ()
{
    NSMutableArray *m_Array100Number;
    NSInteger m_CurrentNumber;
}

@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTitle;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonHome;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonBack;

@property (weak, nonatomic) IBOutlet UIView *m_UIViewSocre;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelYourScore;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelScore;

@property (weak, nonatomic) IBOutlet UIView *m_UIView3Buttons;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonPlayAgain;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonStatistics;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonShareScore;


@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelCopyright;

@property (strong, nonatomic) UILabel *m_MoreAppText;
@property (strong, nonatomic) UIScrollView *m_MoreAppScrollView;

@end

@implementation GameOverViewController
@synthesize m_UIButtonBack, m_UIViewFooter,m_UIButtonHome,m_UIButtonPlayAgain,
m_UIButtonShareScore, m_UIButtonStatistics, m_UILabelCopyright,
m_UILabelScore, m_UILabelTitle, m_UILabelYourScore,
m_UIView3Buttons, m_UIViewHeader, m_UIViewSocre;
@synthesize m_MoreAppScrollView, m_MoreAppText;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    
    if ([[Configuration GetSingleton] GetMoreApps].count <= 0)
    {
        [[Configuration GetSingleton] LoadMoreApps:self];
    }
    else
    {
        [self SetupMoreAppView];
    }
    
    [m_UILabelScore setText:[NSString stringWithFormat:@"%li / 100", (long)m_CurrentNumber]];
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[GADMasterViewController GetSingleton] ResetAdInterstitialView:self];
}

- (void)viewWillAppear:(BOOL)animated
{
 
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor colorWithRed:0/255.0 green:66/255.0 blue:66/255.0 alpha:0.9]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    //2. Header
    
    // back
    CGRect frm = m_UIButtonBack.frame;
    frm.size.width = W_ICON * W;
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.width -= 5;
    }else if(IS_IPAD)
    {
        frm.size.width -= 15;
    }
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/2 * frm.size.width;
    frm.origin.y = 1.0/2 * frm.size.height;
    m_UIButtonBack.frame =frm;
    
    // header
    frm = m_UIViewHeader.frame;
    frm.size.width = W;
    frm.size.height = 2 * m_UIButtonBack.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIViewHeader.frame = frm;
    
    //home
    frm = m_UIButtonBack.frame;
    frm.origin.x = m_UIViewHeader.frame.size.width - frm.size.width - 1.0/2 * frm.size.width;
    m_UIButtonHome.frame = frm;
    
    //title
    frm = m_UIViewHeader.frame;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTitle.frame = frm;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
    {
        [m_UILabelTitle setFont:[UIFont systemFontOfSize:20 weight:1.0]];
    }
    else if (IS_IPAD_1X || IS_IPAD_2X)
    {
        [m_UILabelTitle setFont:[UIFont systemFontOfSize:26 weight:1.0]];
    }
    else if (IS_IPAD_PRO)
    {
        [m_UILabelTitle setFont:[UIFont systemFontOfSize:29 weight:1.0]];
    }
    else
    {
        [m_UILabelTitle setFont:[UIFont systemFontOfSize:23 weight:1.0]];
    }
    
    //3 Your Score
    frm = m_UIViewSocre.frame;
    frm.size.width = W - m_UIButtonBack.frame.size.width;
    frm.size.height = H_YOURSCORE * H;
    frm.origin.x = m_UIButtonBack.frame.origin.x + 1.0/4 * m_UIButtonBack.frame.size.width;
    frm.origin.y = m_UIViewHeader.frame.origin.y + m_UIViewHeader.frame.size.height +  m_UIButtonBack.frame.size.height;
    m_UIViewSocre.frame = frm;
    m_UIViewSocre.layer.cornerRadius = 10;
    [m_UIViewSocre setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    
    //yourscore
    frm = m_UIViewSocre.frame;
    frm.size.height = 1.0/3 * frm.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelYourScore.frame = frm;
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
    {
        [m_UILabelYourScore setFont:[UIFont systemFontOfSize:16 weight:0.3]];
    }
    else if (IS_IPAD_1X || IS_IPAD_2X)
    {
        [m_UILabelYourScore setFont:[UIFont systemFontOfSize:23 weight:0.3]];
    }
    else if (IS_IPAD_PRO)
    {
        [m_UILabelYourScore setFont:[UIFont systemFontOfSize:26 weight:0.3]];
    }
    else
    {
        [m_UILabelYourScore setFont:[UIFont systemFontOfSize:20 weight:0.3]];
    }

    
    //score
    frm = m_UILabelScore.frame;
    frm.size.width = m_UIViewSocre.frame.size.width;
    frm.size.height = 1.0/4 * m_UIViewSocre.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = (m_UIViewSocre.frame.size.height - frm.size.height) * 1.0/2;
    m_UILabelScore.frame = frm;
   
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
    {
        [m_UILabelScore setFont:[UIFont systemFontOfSize:22 weight:0.5]];
    }
    else if (IS_IPAD_1X || IS_IPAD_2X)
    {
        [m_UILabelScore setFont:[UIFont systemFontOfSize:28 weight:0.5]];
    }
    else if (IS_IPAD_PRO)
    {
        [m_UILabelScore setFont:[UIFont systemFontOfSize:31 weight:0.5]];
    }
    else
    {
        [m_UILabelScore setFont:[UIFont systemFontOfSize:25 weight:0.5]];
    }
    
    //4 View 3Buttons
    frm = m_UIView3Buttons.frame;
    frm.size.width = m_UILabelScore.frame.size.width * 1.0/2;
    frm.size.height = H_3BUTTONS * H;
    frm.origin.x = (W - frm.size.width) * 1.0/2;
    frm.origin.y = m_UIViewSocre.frame.origin.y + m_UIViewSocre.frame.size.height + 0.5 *m_UIButtonBack.frame.size.height;
   
    m_UIView3Buttons.frame = frm;
    
    //play again
    frm.size.width = m_UIView3Buttons.frame.size.width;
    frm.size.height = 1/3.5 * m_UIView3Buttons.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIButtonPlayAgain.frame = frm;
    m_UIButtonPlayAgain.layer.cornerRadius = 10;
    m_UIButtonPlayAgain.titleLabel.font = m_UILabelYourScore.font;
    [m_UIButtonPlayAgain setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    [m_UIButtonPlayAgain setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonPlayAgain setTitle:[NSString stringWithFormat:@"PLAY AGAIN"] forState:UIControlStateNormal];
   
    //statistics
    frm.origin.y = m_UIButtonPlayAgain.frame.origin.y + m_UIButtonPlayAgain.frame.size.height + 1.0/4 * m_UIButtonPlayAgain.frame.size.height;
    m_UIButtonStatistics.frame = frm;
    m_UIButtonStatistics.layer.cornerRadius = 10;
    m_UIButtonStatistics.titleLabel.font = m_UIButtonPlayAgain.titleLabel.font;
    [m_UIButtonStatistics setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    [m_UIButtonStatistics setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonStatistics setTitle:[NSString stringWithFormat:@"STATISTICS"] forState:UIControlStateNormal];
    
    //share score
    frm.origin.y = m_UIButtonStatistics.frame.origin.y + m_UIButtonStatistics.frame.size.height + 1.0/4 *m_UIButtonPlayAgain.frame.size.height;
    m_UIButtonShareScore.frame = frm;
    m_UIButtonShareScore.layer.cornerRadius = 10;
    m_UIButtonShareScore.titleLabel.font = m_UIButtonPlayAgain.titleLabel.font;
    [m_UIButtonShareScore setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    [m_UIButtonShareScore setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonShareScore setTitle:[NSString stringWithFormat:@"SHARE"] forState:UIControlStateNormal];
    
    //Footer
    frm = m_UIViewFooter.frame;
    frm.size.width = SCREEN_WIDTH;
    if(SCREEN_HEIGHT <= 400){frm.size.height = 32;}else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720){frm.size.height = 50;}else if(SCREEN_HEIGHT > 720){frm.size.height = 90;};
    frm.origin.x = 0;
    frm.origin.y = SCREEN_HEIGHT - frm.size.height;
    m_UIViewFooter.frame = frm;
    m_UIViewFooter.backgroundColor = [UIColor clearColor];
    
    //Copyrith
    frm = m_UIViewFooter.frame;
    frm.origin.x = 0;
    frm.origin.y =  0;
    m_UILabelCopyright.frame = frm;
    [m_UILabelCopyright setTextColor:[UIColor darkGrayColor]];
    [m_UILabelCopyright setText:TEXT_COPYRIGHT];
    if (IS_IPHONE_4_OR_LESS)
    {
        [m_UILabelCopyright setFont:[UIFont systemFontOfSize:10 weight:0.5]];
    }
    else if (IS_IPAD)
    {
        [m_UILabelCopyright setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    }
    else
    {
        [m_UILabelCopyright setFont:[UIFont systemFontOfSize:15 weight:0.5]];
    }

    
    
    //more app
    CGRect l_frm = CGRectMake(0, 0, 0, 0);
    l_frm.size.width = SCREEN_WIDTH - 20;
    l_frm.origin.x = 10;
    l_frm.size.height = 2.0/9 * SCREEN_WIDTH;
    l_frm.origin.y = SCREEN_HEIGHT - l_frm.size.height - m_UIViewFooter.frame.size.height;
    self.m_MoreAppScrollView = [[UIScrollView alloc] initWithFrame:l_frm];
    [[m_MoreAppScrollView layer ] setCornerRadius:5];
    [[m_MoreAppScrollView layer] setBorderWidth:1];
    [[m_MoreAppScrollView layer] setBorderColor:([[UIColor colorWithRed:253.0/155 green:189.0/255 blue:190.0/255 alpha:0.9] CGColor])];
    m_MoreAppScrollView.backgroundColor = [UIColor clearColor];
    [m_MoreAppScrollView setScrollEnabled:true];
    [m_MoreAppScrollView setShowsHorizontalScrollIndicator:true];
    m_MoreAppScrollView.bounces = true;
    //text
    CGRect l_txtfrm = CGRectMake(0, 0, 0, 0);
    l_txtfrm.size.width = m_MoreAppScrollView.frame.size.width;
    l_txtfrm.size.height = 35;
    l_txtfrm.origin.x = m_MoreAppScrollView.frame.origin.x;
    l_txtfrm.origin.y = m_MoreAppScrollView.frame.origin.y - l_txtfrm.size.height;
    
    m_MoreAppText = [[UILabel alloc] initWithFrame:l_txtfrm];
    m_MoreAppText.textColor = [UIColor whiteColor];
    
    
    CGFloat l_size = 0.0;
    if (IS_IPHONE)
    {
        if (IS_IPHONE_4_OR_LESS)
        {
            l_size = 12.0;
        }
        else if (IS_IPHONE_5)
        {
            l_size = 12.0;
        }
        else if (IS_IPHONE_6)
        {
            l_size = 14.0;
        }
        else if (IS_IPHONE_6P)
        {
            l_size = 15.0;
        }
        
    }
    else if (IS_IPAD)
    {
        if (IS_IPAD_1X)
        {
            l_size = 15.0;
        }
        else if (IS_IPAD_2X)
        {
            l_size = 20.0;
        }
        else if (IS_IPAD_PRO)
        {
            l_size = 28.0;
        }
    }
    
    UIFont *l_font = [UIFont fontWithName:@"AvenirNext-Bold" size:l_size];
    m_MoreAppText.font = l_font;
    m_MoreAppText.text = @"More Apps:";
    
    [self.view addSubview:m_MoreAppScrollView];
    [self.view addSubview:m_MoreAppText];
    
}


- (IBAction)BackClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [self performSegueWithIdentifier:@"Segue2SinglePlayer" sender:self];
}
- (IBAction)HomeClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

- (IBAction)PlayAgainClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [self performSegueWithIdentifier:@"Segue2SinglePlayer" sender:self];
}

- (IBAction)StatisticsClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}


- (IBAction)ShareScoreClick:(id)sender
{
    
    [[SoundController GetSingleton] PlayClickButton];
    NSString * message = @"#1 to 100 Numbers";
    UIImage * image = [[Configuration GetSingleton] TakeScreenshot];
    
    NSArray * shareItems = @[message, image];
    UIActivityViewController * ActivityVC = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    ActivityVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    ActivityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
    [self presentViewController:ActivityVC animated:YES completion:nil];
    
    ActivityVC.completionHandler = ^(NSString *activityType, BOOL completed)
    {
        if (completed)
        {
             NSLog(@"Selected activity was performed.");
        }
        else
        {
            if (activityType == NULL)
            {
                   NSLog(@"User dismissed the view controller without making a selection.");
            } else
            {
                    NSLog(@"Activity was not performed.");
            }
        }
    };
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1000 && buttonIndex == 1)
    {
        //code for opening settings app in iOS 8
        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    }
}


- (void)SetArrayNumber: (NSMutableArray*) p_array
{
    m_Array100Number = [[NSMutableArray alloc] init];
    m_Array100Number = p_array;
}

- (void)SetCurrentNumber: (NSInteger) p_index
{
    m_CurrentNumber = p_index;
}

- (void) SetupMoreAppView
{
    
    CGFloat l_height = 0.9 * m_MoreAppScrollView.frame.size.height;
    CGFloat l_y = 0.05 * l_height;
    CGFloat l_space = 0.1 * l_height;
    CGRect l_frame = CGRectMake(0, l_y, l_height, l_height);
    
    for (int i = 0; i < [[Configuration GetSingleton] GetMoreApps].count; i++)
    {
        l_frame.origin.x = l_space + (l_frame.size.width + l_space) * i;
        UIButton *l_btn = [[UIButton alloc] initWithFrame:l_frame];
        l_btn.layer.cornerRadius = l_height / 5;
        l_btn.layer.borderWidth = l_height / 20;
        l_btn.layer.borderColor = [[UIColor colorWithRed:241.0/255 green:241.0/255 blue:241.0/255 alpha:1] CGColor];
        
        l_btn.tag = i;
        [self GetImageForBtn:l_btn];
        [l_btn addTarget:self action:@selector(MoreAppClick:) forControlEvents:UIControlEventTouchUpInside];
        [m_MoreAppScrollView addSubview:l_btn];
    }
    
    CGSize l_size = CGSizeMake([[Configuration GetSingleton] GetMoreApps].count * (l_height + l_space) + l_space, m_MoreAppScrollView.frame.size.height);
    [m_MoreAppScrollView setContentSize: l_size];
    
}

-(void) MoreAppClick: (UIButton*) sender
{
    
    //[[SoundController GetSingleton] PlayClickButton];
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
#else
    NSString *l_linkapp = [[Configuration GetSingleton] GetMoreApps][sender.tag][2];
    NSURL *l_url = [[NSURL alloc] initWithString:l_linkapp];
    [[UIApplication sharedApplication] openURL:l_url];
#endif
    
}

- (void) GetImageForBtn: (UIButton*) p_sender
{
    NSArray *l_dic = [[Configuration GetSingleton] GetMoreApps][p_sender.tag];
    NSString *l_nameimg = [[NSSearchPathForDirectoriesInDomains(
                                                                      NSDocumentDirectory,
                                                                      NSUserDomainMask, YES
                                                                      ) objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@", l_dic[1]]];
    UIGraphicsBeginImageContext([p_sender frame].size);
    [[UIImage imageNamed:l_dic[1]] drawInRect:[p_sender bounds]];
    UIImage *l_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [p_sender  setBackgroundColor:[UIColor colorWithPatternImage:l_image]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    

    if ([[segue identifier] isEqualToString:@"Segue2SinglePlayer"])
    {
        SinglePlayerViewController *MyView = (SinglePlayerViewController*)[segue destinationViewController];
        [MyView SetArrayNumber:m_Array100Number];
        [MyView SetStateGame:BACKVIEW];
    }
    
    if ([[segue identifier] isEqualToString:@"Segue2Statistics"])
    {
        StatisticsViewController *MyView = (StatisticsViewController*)[segue destinationViewController];
        [MyView SetArrayNumber:m_Array100Number];
        //[MyView SetStateGame:BACKVIEW];
    }
}


@end
