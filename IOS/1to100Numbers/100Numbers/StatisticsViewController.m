//
//  ViewController.m
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 4/3/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <Social/Social.h>
#import "StatisticsViewController.h"
#import "SoundController.h"
#import "SinglePlayerViewController.h"
#import "GADMasterViewController.h"
#import "SoundController.h"
#import "Configuration.h"
#import "Define.h"

@interface StatisticsViewController ()
{
   NSMutableArray *m_Array100Number;
}

@property (weak, nonatomic) IBOutlet UIView *m_UIViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTitle;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonHome;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonBack;

@property (weak, nonatomic) IBOutlet UIView *m_UIViewBestSocre;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTitleBestScore;

@property (weak, nonatomic) IBOutlet UILabel *m_UILabelBestScore;

@property (weak, nonatomic) IBOutlet UIView *m_UIViewOverall;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelAverageScore;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelGamesPlayed;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTitleAverageScore;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTileGamesPlayed;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTitleOverall;

@property (weak, nonatomic) IBOutlet UIView *m_UIView2Buttons;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonClearScore;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonShareScore;


@property (weak, nonatomic) IBOutlet UIView *m_UIViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelCopyright;



@end

@implementation StatisticsViewController
@synthesize m_UIViewFooter, m_UIButtonBack, m_UIButtonClearScore, m_UIButtonHome,
m_UIButtonShareScore, m_UILabelAverageScore,m_UILabelBestScore, m_UILabelCopyright,
m_UILabelGamesPlayed, m_UILabelTileGamesPlayed, m_UILabelTitle, m_UILabelTitleAverageScore,
m_UILabelTitleBestScore, m_UILabelTitleOverall, m_UIView2Buttons, m_UIViewBestSocre,
m_UIViewHeader, m_UIViewOverall;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithRed:0/255.0 green:66/255.0 blue:66/255.0 alpha:0.9]];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self LoadData];
    [self CalculateView];
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
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
    
    //3 Best Score
    frm = m_UIViewBestSocre.frame;
    frm.size.width = W - m_UIButtonBack.frame.size.width;
    frm.size.height = H_YOURSCORE * H;
    frm.origin.x = m_UIButtonBack.frame.origin.x + 1.0/4 * m_UIButtonBack.frame.size.width;
    frm.origin.y =m_UIViewHeader.frame.origin.y + m_UIViewHeader.frame.size.height + m_UIButtonBack.frame.size.height;
    m_UIViewBestSocre.frame = frm;
     m_UIViewBestSocre.layer.cornerRadius = 10;
    [m_UIViewBestSocre setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    
    //Bestscore title
    frm = m_UIViewBestSocre.frame;
    frm.size.height = 1.0/3 * frm.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTitleBestScore.frame = frm;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
    {
        [m_UILabelTitleBestScore setFont:[UIFont systemFontOfSize:17 weight:0.3]];
    }
    else if (IS_IPAD_1X || IS_IPAD_2X)
    {
        [m_UILabelTitleBestScore setFont:[UIFont systemFontOfSize:23 weight:0.3]];
    }
    else if (IS_IPAD_PRO)
    {
        [m_UILabelTitleBestScore setFont:[UIFont systemFontOfSize:26 weight:0.3]];
    }
    else
    {
        [m_UILabelTitleBestScore setFont:[UIFont systemFontOfSize:20 weight:0.3]];
    }
    
    //best score
    frm = m_UILabelBestScore.frame;
    frm.size.width = m_UIViewBestSocre.frame.size.width;
    frm.size.height = 1.0/4 * m_UIViewBestSocre.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = (m_UIViewBestSocre.frame.size.height - frm.size.height) * 1.0/2;
    m_UILabelBestScore.frame = frm;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
    {
        [m_UILabelBestScore setFont:[UIFont systemFontOfSize:22 weight:0.5]];
    }
    else if (IS_IPAD_1X || IS_IPAD_2X)
    {
        [m_UILabelBestScore setFont:[UIFont systemFontOfSize:28 weight:0.5]];
    }
    else if (IS_IPAD_PRO)
    {
        [m_UILabelBestScore setFont:[UIFont systemFontOfSize:31 weight:0.5]];
    }
    else
    {
        [m_UILabelBestScore setFont:[UIFont systemFontOfSize:25 weight:0.5]];
    }
    //4. Overall
    frm = m_UIViewBestSocre.frame;
    frm.origin.y = frm.origin.y + frm.size.height + 1.0/2 * m_UIButtonBack.frame.size.height;
    m_UIViewOverall.frame = frm;
    m_UIViewOverall.layer.cornerRadius = 10;
    [m_UIViewOverall setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    
    //title
    frm = m_UIViewOverall.frame;
    frm.size.height = 1.0/4 * frm.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTitleOverall.frame = frm;
    m_UILabelTitleOverall.font = m_UILabelTitleBestScore.font;
    
    //average score title
    frm = m_UILabelTitleAverageScore.frame;
    frm.size.width = m_UIViewOverall.frame.size.width;
    frm.size.height = 1.0/5 * m_UIViewOverall.frame.size.height;
    frm.origin.x = 1.0/20 * m_UIViewOverall.frame.size.width;
    frm.origin.y = (m_UIViewOverall.frame.size.height - frm.size.height) * 1.0/2;
    m_UILabelTitleAverageScore.frame = frm;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
    {
        [m_UILabelTitleAverageScore setFont:[UIFont systemFontOfSize:15 weight:0.2]];
    }
    else if (IS_IPAD_1X || IS_IPAD_2X)
    {
        [m_UILabelTitleAverageScore setFont:[UIFont systemFontOfSize:21 weight:0.2]];
    }
    else if (IS_IPAD_PRO)
    {
        [m_UILabelTitleAverageScore setFont:[UIFont systemFontOfSize:24 weight:0.2]];
    }
    else
    {
        [m_UILabelTitleAverageScore setFont:[UIFont systemFontOfSize:18 weight:0.2]];
    }

    
    //averagesocore
    frm = m_UILabelTitleAverageScore.frame;
    frm.origin.x = -1.0/20 * m_UIViewOverall.frame.size.width;
    m_UILabelAverageScore.frame = frm;
    m_UILabelAverageScore.font = m_UILabelTitleAverageScore.font;
    
    //Games palyed title
    frm = m_UILabelTitleAverageScore.frame;
    frm.origin.y = frm.origin.y + frm.size.height;
    m_UILabelTileGamesPlayed.frame = frm;
    m_UILabelTileGamesPlayed.font = m_UILabelTitleAverageScore.font;
    
    //game played
    frm = m_UILabelTileGamesPlayed.frame;
    frm.origin.x = m_UILabelAverageScore.frame.origin.x;
    m_UILabelGamesPlayed.frame = frm;
    m_UILabelGamesPlayed.font = m_UILabelTitleAverageScore.font;
    
    //4 View 2Buttons
    frm = m_UIView2Buttons.frame;
    frm.size.width = m_UIViewOverall.frame.size.width;
    frm.size.height = H_3BUTTONS * H * 1.0/3.5;
    frm.origin.x = m_UIViewOverall.frame.origin.x;
    frm.origin.y = m_UIViewOverall.frame.origin.y + m_UIViewOverall.frame.size.height + 1.0/2 * m_UIButtonBack.frame.size.height;
    m_UIView2Buttons.frame = frm;
    
    //clear score
    frm = m_UIView2Buttons.frame;
    frm.size.width = 1.0/2 * (m_UIView2Buttons.frame.size.width - 1.0/16*m_UIView2Buttons.frame.size.width);
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIButtonClearScore.frame = frm;
    m_UIButtonClearScore.layer.cornerRadius = 10;
    [m_UIButtonClearScore setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    m_UIButtonClearScore.titleLabel.font = m_UILabelTitleBestScore.font;
    [m_UIButtonClearScore setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonClearScore setTitle:[NSString stringWithFormat:@"CLEAR"] forState:UIControlStateNormal];
    
    //share score
    frm = m_UIButtonClearScore.frame;
    frm.origin.x = frm.origin.x + frm.size.width + 1.0/8 * frm.size.width;
    m_UIButtonShareScore.frame = frm;
    m_UIButtonShareScore.layer.cornerRadius = 10;
    [m_UIButtonShareScore setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    m_UIButtonShareScore.titleLabel.font = m_UILabelTitleBestScore.font;
    [m_UIButtonShareScore setTitleColor:[UIColor colorWithRed:160/255.0 green:189/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonShareScore setTitle:[NSString stringWithFormat:@"SHARE"] forState:UIControlStateNormal];
    
    //Footer
    frm = m_UIViewFooter.frame;
    frm.size.width = SCREEN_WIDTH;
    if(SCREEN_HEIGHT <= 400){frm.size.height = 32;}else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720){frm.size.height = 50;}else if(SCREEN_HEIGHT > 72){frm.size.height = 90;};
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
    
}

- (void)LoadData
{
   
    if ([[Configuration GetSingleton] GetTimesPlayed] < 0)
    {
        m_UILabelBestScore.text = @"--";
        m_UILabelAverageScore.text = @"--";
        m_UILabelGamesPlayed.text = @"--";
    }
    else
    {
       
        m_UILabelBestScore.text = [NSString stringWithFormat:@"%li / 100", (long)[[Configuration GetSingleton] GetBestScore]];
        m_UILabelAverageScore.text = [NSString stringWithFormat:@"%li",(long)[[Configuration GetSingleton]GetAverageScore ]];
        m_UILabelGamesPlayed.text = [NSString stringWithFormat:@"%li", (long)[[Configuration GetSingleton] GetTimesPlayed]];
    }
   
}

- (IBAction)BackClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

- (IBAction)ClearScoreClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    NSString *title = @"CLEAR SCORES" ;
    NSString *msg = @"This will erase all scores & achievements.\n\n Are you sure?" ;
    NSString *titleCancel = @"CANCEL";
    NSString *titleSetting   = @"CLEAR";

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:titleSetting ,nil];
    alert.tag = 1001;
    [alert show];
    
    
}

- (IBAction)ShareFacebook:(id)sender
{
//    [[SoundController GetSingleton] PlayClickButton];
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//    {
//        SLComposeViewController *fbSheet = [SLComposeViewController
//                                            composeViewControllerForServiceType:SLServiceTypeFacebook];
//        [fbSheet setInitialText:@"#Find 100 Numbers"];
//        //NSString *l_url = [NSString stringWithFormat:@"%@%@",@"https://itunes.apple.com/app/id", YOUR_APP_ID];
//        //[fbSheet addURL:[NSURL URLWithString:l_url]];
//        [fbSheet addImage:[self takeScreenshot]];
//        [self presentViewController:fbSheet animated:YES completion:nil];
//    }
//    else
//    {
//        NSString *title = @"No Facebook Account" ;
//        NSString *msg = @"You can add or create a Facebook acount in Settings->Facebook" ;
//        NSString *titleCancel = @"CANCEL";
//        NSString *titleSetting   = @"SETTING";
//        
//        //BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
//        //if (canOpenSettings) {
//        if([[[UIDevice currentDevice] systemVersion] floatValue]<8.0)
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:titleSetting ,nil];
//            //alert.tag = 1000;
//            [alert show];
//        }
//        else
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:titleSetting ,nil];
//            alert.tag = 1000;
//            [alert show];
//        }
//        
//    }
    
    [[SoundController GetSingleton] PlayClickButton];
    NSString * message = @"#Find 100 Numbers";
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
    
    if (alertView.tag == 1001 && buttonIndex == 1)
    {
        [[Configuration GetSingleton] ClearConfig];
        [self LoadData];
    }
}


- (void)SetArrayNumber: (NSMutableArray*) p_array
{
    m_Array100Number = [[NSMutableArray alloc] init];
    m_Array100Number = p_array;
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
    
    
    
    
}


@end
