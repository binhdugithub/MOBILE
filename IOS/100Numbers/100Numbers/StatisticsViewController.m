//
//  ViewController.m
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 4/3/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "StatisticsViewController.h"
#import "SoundController.h"
#import "SinglePlayerViewController.h"
#import <Social/Social.h>
#import "GADMasterViewController.h"
#import "Configuration.h"

@interface StatisticsViewController ()
{
   NSMutableArray *m_Array100Number;
    GADInterstitial *interstitial;
    NSTimer *m_Timer;
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
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self LoadData];
    [self CalculateView];
    [[GADMasterViewController singleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
    
    [self SetupAdvertisementInterstitial];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) SetupAdvertisementInterstitial
{
    //Advertisement
    interstitial = [[GADInterstitial alloc] init];
    interstitial = [[GADInterstitial alloc] init];
    interstitial.adUnitID = AMOD_INTERSTITIAL_UNIT;
    [interstitial loadRequest:[GADRequest request]];
    //End Advertisement
    
    m_Timer = [NSTimer scheduledTimerWithTimeInterval:AMOD_INTERSTITIAL_TIMEOUT
                                               target:self
                                             selector:@selector(ShowAdvertisement:)
                                             userInfo:nil
                                              repeats:NO];
    
}

- (void) ShowAdvertisement: (NSTimer*)p_timer
{
    if ([interstitial isReady])
    {
        
        [interstitial presentFromRootViewController:self];
        
    }else
    {
        NSLog(@"GADInterstitial not ready");
    }
    
    
    [p_timer invalidate];
    p_timer = nil;
    
}

-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //1 bacground
    
    //[self.view setBackgroundColor:[UIColor colorWithRed:83/255.0 green:162/255.0 blue:201/255.0 alpha:1]];
    //[self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self.view setBackgroundColor:[UIColor colorWithRed:0/255.0 green:66/255.0 blue:66/255.0 alpha:1]];
    //2. Header
    
    // back
    CGRect frm = m_UIButtonBack.frame;
    frm.size.width = W_ICON * W;
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/4 * frm.size.width;
    frm.origin.y = 1.0/4 * frm.size.height;
    m_UIButtonBack.frame =frm;
    
    // header
    frm = m_UIViewHeader.frame;
    frm.size.width = W;
    frm.size.height = 3.0/2 * m_UIButtonBack.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIViewHeader.frame = frm;
    
    //home
    frm = m_UIButtonBack.frame;
    frm.origin.x = m_UIViewHeader.frame.size.width - frm.size.width - 1.0/4 * frm.size.width;
    m_UIButtonHome.frame = frm;
    
    //title
    frm = m_UIViewHeader.frame;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTitle.frame = frm;
    
    
    //3 Best Score
    frm = m_UIViewBestSocre.frame;
    frm.size.width = W - m_UIButtonBack.frame.size.width;
    frm.size.height = H_YOURSCORE * H;
    frm.origin.x = m_UIButtonBack.frame.origin.x + 1.0/4 * m_UIButtonBack.frame.size.width;
    frm.origin.y =m_UIViewHeader.frame.origin.y + m_UIViewHeader.frame.size.height +  1.0/2 * m_UIButtonBack.frame.size.height;
    m_UIViewBestSocre.frame = frm;
     m_UIViewBestSocre.layer.cornerRadius = 10;
    [m_UIViewBestSocre setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    
    //Bestscore title
    frm = m_UIViewBestSocre.frame;
    frm.size.height = 1.0/4 * frm.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTitleBestScore.frame = frm;
    
    //best score
    frm = m_UILabelBestScore.frame;
    frm.size.width = m_UIViewBestSocre.frame.size.width;
    frm.size.height = 1.0/4 * m_UIViewBestSocre.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = (m_UIViewBestSocre.frame.size.height - frm.size.height) * 1.0/2;
    m_UILabelBestScore.frame = frm;
    
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
    
    //average score title
    frm = m_UILabelTitleAverageScore.frame;
    frm.size.width = m_UIViewOverall.frame.size.width;
    frm.size.height = 1.0/5 * m_UIViewOverall.frame.size.height;
    frm.origin.x = 1.0/20 * m_UIViewOverall.frame.size.width;
    frm.origin.y = (m_UIViewOverall.frame.size.height - frm.size.height) * 1.0/2;
    m_UILabelTitleAverageScore.frame = frm;
    
    //averagesocore
    frm = m_UILabelTitleAverageScore.frame;
    frm.origin.x = -1.0/20 * m_UIViewOverall.frame.size.width;
    m_UILabelAverageScore.frame = frm;
    
    //Games palyed title
    frm = m_UILabelTitleAverageScore.frame;
    frm.origin.y = frm.origin.y + frm.size.height;
    m_UILabelTileGamesPlayed.frame = frm;
    
    //game played
    frm = m_UILabelTileGamesPlayed.frame;
    frm.origin.x = m_UILabelAverageScore.frame.origin.x;
    m_UILabelGamesPlayed.frame = frm;
    
    
    //4 View 2Buttons
    frm = m_UIView2Buttons.frame;
    frm.size.width = m_UIViewOverall.frame.size.width;
    frm.size.height = H_3BUTTONS * H * 1.0/3.5;
    frm.origin.x = m_UIViewOverall.frame.origin.x;
    frm.origin.y = m_UIViewOverall.frame.origin.y + m_UIViewOverall.frame.size.height + 1.0/2 * m_UIButtonBack.frame.size.height;
    m_UIView2Buttons.frame = frm;
    
    //play clear score
    frm = m_UIView2Buttons.frame;
    frm.size.width = 1.0/2 * (m_UIView2Buttons.frame.size.width - 1.0/16*m_UIView2Buttons.frame.size.width);
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIButtonClearScore.frame = frm;
    m_UIButtonClearScore.layer.cornerRadius = 10;
    [m_UIButtonClearScore setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    m_UIButtonClearScore.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
    [m_UIButtonClearScore setTitleColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonClearScore setTitle:[NSString stringWithFormat:@"CLEAR"] forState:UIControlStateNormal];
    
    //share score
    frm = m_UIButtonClearScore.frame;
    frm.origin.x = frm.origin.x + frm.size.width + 1.0/8 * frm.size.width;
    m_UIButtonShareScore.frame = frm;
    m_UIButtonShareScore.layer.cornerRadius = 10;
    [m_UIButtonShareScore setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    m_UIButtonShareScore.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
    [m_UIButtonShareScore setTitleColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonShareScore setTitle:[NSString stringWithFormat:@"SHARE"] forState:UIControlStateNormal];
    
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
    frm.origin.y =  m_UIViewFooter.frame.size.height * 1.0/2;
    m_UILabelCopyright.frame = frm;
    
    
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
    [[SoundController GetSingleton] PlayClickButton];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController
                                            composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet setInitialText:@"Help me! in #20Icon"];
        [fbSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id123456789"]];
        [fbSheet addImage:[self takeScreenshot]];
        
        
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else
    {
        NSString *title = @"No Facebook Account" ;
        NSString *msg = @"You can add or create a Facebook acount in Settings->Facebook" ;
        NSString *titleCancel = @"CANCEL";
        NSString *titleSetting   = @"SETTING";
        
        //BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
        //if (canOpenSettings) {
        if([[[UIDevice currentDevice] systemVersion] floatValue]<8.0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:titleSetting ,nil];
            //alert.tag = 1000;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self  cancelButtonTitle:titleCancel  otherButtonTitles:titleSetting ,nil];
            alert.tag = 1000;
            [alert show];
        }
        
    }
    
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


- (UIImage*) takeScreenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
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
