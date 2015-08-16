//
//  1ResultViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//
#import "SingleResultViewController.h"
#import "SinglePlayerViewController.h"
#import "StatisticsViewController.h"
#include "Define.h"


@interface SingleResultViewController ()
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

@end

@implementation SingleResultViewController
@synthesize m_UIButtonBack, m_UIViewFooter,m_UIButtonHome,m_UIButtonPlayAgain,
m_UIButtonShareScore, m_UIButtonStatistics, m_UILabelCopyright,
m_UILabelScore, m_UILabelTitle, m_UILabelYourScore,
m_UIView3Buttons, m_UIViewHeader, m_UIViewSocre;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [[GADMasterViewController singleton] resetAdBannerView:self AtFrame:m_UIViewFooter.frame];
    [[GADMasterViewController singleton] resetAdInterstitialView:self];
    
    [m_UILabelScore setText:[NSString stringWithFormat:@"%li / 100", (long)m_CurrentNumber]];
    
    
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
    
    //time
    frm = m_UIViewHeader.frame;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelTitle.frame = frm;
    
    //TITLE
    
    
    //3 Your Score
    frm = m_UIViewSocre.frame;
    frm.size.width = W - m_UIButtonBack.frame.size.width;
    frm.size.height = H_YOURSCORE * H;
    frm.origin.x = m_UIButtonBack.frame.origin.x + 1.0/4 * m_UIButtonBack.frame.size.width;
    frm.origin.y =m_UIViewHeader.frame.origin.y + m_UIViewHeader.frame.size.height +  1.0/2 * m_UIButtonBack.frame.size.height;
    m_UIViewSocre.frame = frm;
    m_UIViewSocre.layer.cornerRadius = 10;
    //m_UIViewSocre = [UIFont systemFontOfSize:17 weight:0];
    [m_UIViewSocre setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    
    //title
    frm = m_UIViewSocre.frame;
    frm.size.height = 1.0/4 * frm.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UILabelYourScore.frame = frm;
    m_UILabelYourScore.font = [UIFont systemFontOfSize:17 weight:1];
    //score
    frm = m_UILabelScore.frame;
    frm.size.width = m_UIViewSocre.frame.size.width;
    frm.size.height = 1.0/4 * m_UIViewSocre.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = (m_UIViewSocre.frame.size.height - frm.size.height) * 1.0/2;
    m_UILabelScore.frame = frm;
    
    //4 View 3Buttons
    frm = m_UIView3Buttons.frame;
    frm.size.width = m_UILabelScore.frame.size.width - 4 * m_UIButtonBack.frame.size.width;
    frm.size.height = H_3BUTTONS * H;
    frm.origin.x = (W - frm.size.width) * 1.0/2;
    frm.origin.y = m_UIViewSocre.frame.origin.y + m_UIViewSocre.frame.size.height+ m_UIButtonBack.frame.size.height;
    m_UIView3Buttons.frame = frm;
    
    //play agian
    frm.size.width = m_UIView3Buttons.frame.size.width;
    frm.size.height = 1/3.5 * m_UIView3Buttons.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_UIButtonPlayAgain.frame = frm;
    m_UIButtonPlayAgain.layer.cornerRadius = 10;
    m_UIButtonPlayAgain.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
    [m_UIButtonPlayAgain setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    [m_UIButtonPlayAgain setTitleColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonPlayAgain setTitle:[NSString stringWithFormat:@"PLAY AGAIN"] forState:UIControlStateNormal];
   
    //statistics
    frm.origin.y = m_UIButtonPlayAgain.frame.origin.y + m_UIButtonPlayAgain.frame.size.height + 1.0/4 * m_UIButtonPlayAgain.frame.size.height;
    m_UIButtonStatistics.frame = frm;
    m_UIButtonStatistics.layer.cornerRadius = 10;
    m_UIButtonStatistics.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
    [m_UIButtonStatistics setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
    [m_UIButtonStatistics setTitleColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [m_UIButtonStatistics setTitle:[NSString stringWithFormat:@"STATISTICS"] forState:UIControlStateNormal];
    
    //share score
    frm.origin.y = m_UIButtonStatistics.frame.origin.y + m_UIButtonStatistics.frame.size.height + 1.0/4 *m_UIButtonPlayAgain.frame.size.height;
    m_UIButtonShareScore.frame = frm;
    m_UIButtonShareScore.layer.cornerRadius = 10;
    m_UIButtonShareScore.titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
    [m_UIButtonShareScore setBackgroundColor:[UIColor colorWithRed:0/255.0 green:94.0/255 blue:91.0/255 alpha:1]];
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController
                                            composeViewControllerForServiceType:SLServiceTypeFacebook];
        //[fbSheet setInitialText:@"Help me! in #Find 100 Numbers"];
        //NSString *l_url = [NSString stringWithFormat:@"%@%@",@"https://itunes.apple.com/app/id", YOUR_APP_ID];
        //[fbSheet addURL:[NSURL URLWithString:l_url]];
        [fbSheet addImage:[self takeScreenshot]];
        
        
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

- (void)SetCurrentNumber: (NSInteger) p_index
{
    m_CurrentNumber = p_index;
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
