//
//  ViewController.m
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/17/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "ViewController.h"
#import "SoundController.h"
#import "AboutViewController.h"
#import "GADMasterViewController.h"
#import "GCViewController.h"
#import "Configuration.h"
#import "Define.h"
#import <Social/Social.h>

@interface ViewController ()
{
    NSMutableArray *m_Array100Number;
    NSInteger m_State;
    NSInteger m_CurrentCount;
    NSInteger m_CountPlay;
    
    GADInterstitial* interstitial;
    NSTimer *m_Timer;
}

@property (weak, nonatomic) IBOutlet UIView *View100Number;
@property (weak, nonatomic) IBOutlet UIView *ViewButtons;
@property (weak, nonatomic) IBOutlet UIView *ViewFooter;
@property (weak, nonatomic) IBOutlet UIButton *BtnSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *BtnAbout;
@property (weak, nonatomic) IBOutlet UIButton *BtnPlay;
@property (weak, nonatomic) IBOutlet UIButton *BtnRate;
@property (weak, nonatomic) IBOutlet UIButton *BtnGameCenter;

@property (weak, nonatomic) IBOutlet UILabel *LblCopyright;

@end

@implementation ViewController
@synthesize View100Number, ViewButtons, ViewFooter,BtnAbout, BtnSpeaker, LblCopyright, BtnGameCenter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
    [self ShowSpeaker];
    
    if(m_State == BACKVIEW)
    {
        [self InitBackView];
    }
    else
    {
        m_State = PREPAREPLAY;
        m_CurrentCount = 0;
        [self Init100Number];
    }
    
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:ViewFooter.frame];
    [[GCViewController GetSingleton] AuthenticateLocalPlayer];
    
    m_CountPlay = 0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{

    
}

- (void)SetStateGame: (NSInteger) p_state
{
    m_State = p_state;
}

- (void)SetArrayNumber: (NSMutableArray*) p_array
{
    m_Array100Number = [[NSMutableArray alloc] init];
    m_CurrentCount = 0;
    
    NSInteger count = 0;
    for (UIButton *l_number in p_array)
    {
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:l_number.frame];
        MyNumber.tag = l_number.tag;
        MyNumber.enabled = l_number.enabled;
        MyNumber.layer.cornerRadius = l_number.layer.cornerRadius;
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (MyNumber.tag == -1)
        {
            [MyNumber setBackgroundColor:[UIColor yellowColor]];
            m_CurrentCount++;
        }
        else if(MyNumber.enabled == TRUE)
        {
            [MyNumber setBackgroundColor:[UIColor whiteColor]];
            count++;
            
        }
        else if(MyNumber.tag >= 0)
        {
            [MyNumber setBackgroundColor:[UIColor darkGrayColor]];
        }
       
        
        [m_Array100Number addObject:MyNumber];
    }
    
    if (count == m_Array100Number.count)
    {
        for (UIButton *l_number in m_Array100Number)
        {
            [l_number setBackgroundColor:[UIColor darkGrayColor]];
            l_number.enabled = TRUE;
        }
    }
}

- (void)InitBackView
{
    for (UIButton *MyNumber in m_Array100Number)
    {
        [View100Number addSubview:MyNumber];
    }
    
   m_State = PLAYING;
    
}

-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //1. background
    //[self.view setBackgroundColor:[UIColor darkGrayColor]];
    
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
    if(SCREEN_HEIGHT <= 400)
    {
        frm.size.height = 32;
    }
    else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720)
    {
        frm.size.height = 50;
    }else if(SCREEN_HEIGHT > 720)
    {
        frm.size.height = 90;
    }
    
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    ViewFooter.frame = frm;
    //[m_UIViewHeader setBackgroundColor:[UIColor clearColor]];
    
    //Copyrith
    
    frm = ViewFooter.frame;
    frm.origin.x = 0;
    frm.origin.y =  0;
    LblCopyright.frame = frm;
    [LblCopyright setTextColor:[UIColor darkGrayColor]];
    [LblCopyright setText:TEXT_COPYRIGHT];
    if (IS_IPHONE_4_OR_LESS)
    {
        [LblCopyright setFont:[UIFont systemFontOfSize:10 weight:0.5]];
    }
    else if (IS_IPAD)
    {
        [LblCopyright setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    }
    else
    {
        [LblCopyright setFont:[UIFont systemFontOfSize:15 weight:0.5]];
    }
    
    //4 buttons
    frm = ViewButtons.frame;
    frm.size.width = W;
    frm.size.height = H - View100Number.frame.size.height - ViewFooter.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = View100Number.frame.size.height;
    ViewButtons.frame = frm;
    
    //Play
    frm = ViewButtons.frame;
    frm.size.height = 3.0/4 * ViewButtons.frame.size.height;
    frm.size.width = frm.size.height;
    frm.origin.x = 1.0/2 * (ViewButtons.frame.size.width - frm.size.width);
    frm.origin.y = 1.0/2 * (ViewButtons.frame.size.height - frm.size.height);
    _BtnPlay.frame = frm;
    _BtnPlay.layer.cornerRadius = 1.0/2 * frm.size.width;

    CGFloat w = 1.0/4 * ViewButtons.frame.size.height;
    //CGFloat h = w;
    //1. Rate
    frm = _BtnRate.frame;
    
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.width = 1.2 * w;
    }
    else if (IS_IPAD)
    {
        frm.size.width = 1.2 * w;
    }
    else
    {
        frm.size.width = w;
    }
    
    frm.size.height = frm.size.width;
    frm.origin.x = ViewButtons.frame.size.width - 1.0/8 * frm.size.width - frm.size.width;
    frm.origin.y = _BtnPlay.frame.size.height + _BtnPlay.frame.origin.y - frm.size.height;
    _BtnRate.frame = frm;
    
    //2. GameCenter
    frm = _BtnRate.frame;
    frm.origin.y = _BtnPlay.frame.origin.y;
    BtnGameCenter.frame = frm;
    
    //3.  About
    frm = BtnGameCenter.frame;
    frm.origin.x = 1.0/8 * frm.size.width;
    //frm.origin.y = 1.0/ 2 * ViewButtons.frame.size.height - frm.size.height - 1.0/ 8 * frm.size.height;
    BtnAbout.frame =frm;
    
    //4. Speaker
    frm = _BtnRate.frame;
    frm.origin.x = 1.0/8 * frm.size.width;
    //frm.origin.y = 1.0/ 2 * ViewButtons.frame.size.height + 1.0/ 8 * frm.size.height;
    BtnSpeaker.frame = frm;
    
}

- (void)Init100Number
{
    m_Array100Number = [[NSMutableArray alloc] init];
    CGFloat w = [UIScreen mainScreen].bounds.size.width / (9.0/20 + 10);
    CGFloat h = w;

    for (NSUInteger i=0; i < 100; i++)
    {
        CGFloat x = (i % 10) * (1.0/ 20 + 1) * w;
        CGFloat y = (i / 10) * (1.0/20 + 1) * h;
        
        UIButton *MyNumber = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
        MyNumber.frame = CGRectMake(x, y, w, h);
        MyNumber.tag = i;
        [MyNumber addTarget:self action:@selector(NumberClick:) forControlEvents:UIControlEventTouchUpInside];
        [MyNumber setBackgroundColor:[UIColor darkGrayColor]];
        MyNumber.layer.cornerRadius = 5;
       
        [View100Number addSubview:MyNumber];
        [m_Array100Number addObject:MyNumber];
    }
}


- (void)NumberClick: (UIButton*)sender
{
    [[SoundController GetSingleton] PlaySoundCorrect];
    
    bool gameOver = true;
    
   // printf("Size Array: %i", m_Array100Number.count);
    for(UIButton *MyButton in m_Array100Number)
    {
        MyButton.enabled = FALSE;
        
        if (MyButton.tag != -1)
        {
            [MyButton setBackgroundColor:[UIColor darkGrayColor]];
        }
        
    }
   
   if(m_State == PREPAREPLAY)
       m_State = PLAYING;
    
    if (m_State == BACKVIEW) {
        m_State = PLAYING;
    }
    

    NSInteger x = sender.tag % 10;
    NSInteger y = sender.tag / 10;
    
    //printf("x: %i y: %i\n", x, y);
    if (x+ 3 <= 9)
    {
        //NSInteger index = y * 10 + x + 3;
       // printf("%i", index);
        UIButton *SuggestNumber = m_Array100Number[y * 10 + x + 3];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
            SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }
    
    
    if (x - 3 >= 0)
    {
        //NSInteger index = y * 10 + x - 3;
        //printf("%i", index);
        
        UIButton *SuggestNumber = m_Array100Number[y * 10 + x - 3];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
             SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }
    
    
    if (y + 3 <= 9)
    {
       // NSInteger index = (y + 3) * 10 + x;
        //printf("%i", index);
        UIButton *SuggestNumber = m_Array100Number[(y + 3) * 10 + x];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
             SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }
    
    
    if (y - 3 >= 0)
    {
        //NSInteger index = (y - 3) * 10 + x;
        //printf("%i", index);
        
        UIButton *SuggestNumber = m_Array100Number[(y - 3) * 10 + x];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
            SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }
    
    if (y - 2 >= 0 && x - 2 >=0)
    {
       // NSInteger index = (y - 2) * 10 + x - 2;
        //printf("%i", index);
        
        UIButton *SuggestNumber = m_Array100Number[(y - 2) * 10 + x - 2];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
            SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }
    
    if (y - 2 >= 0 && x + 2 <=9)
    {
       // NSInteger index = (y - 2) * 10 + x + 2;
       // printf("%i", index);
        UIButton *SuggestNumber = m_Array100Number[(y - 2) * 10 + x + 2];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
            SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }

    if (y + 2 <= 9 && x - 2 >=0)
    {
        //NSInteger index = (y + 2) * 10 + x - 2;
       // printf("%i", index);
        UIButton *SuggestNumber = m_Array100Number[(y + 2) * 10 + x - 2];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
            SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }
    
    if (y + 2 <= 9 && x + 2 <=9)
    {
        //NSInteger index = (y + 2) * 10 + x + 2;
       // printf("%i", index);
        UIButton *SuggestNumber = m_Array100Number[(y + 2) * 10 + x + 2];
        if (SuggestNumber.tag != -1)
        {
            [SuggestNumber setBackgroundColor:[UIColor whiteColor]];
            SuggestNumber.enabled = TRUE;
            gameOver = false;
        }
    }
    
    
    [sender setBackgroundColor:[UIColor yellowColor]];
     sender.tag = -1;
    
    m_CurrentCount++;
    
    if (gameOver)
    {
        //m_CountPlay ++;
        m_State = GAMEOVER;
        if (m_CurrentCount > [[Configuration GetSingleton] GetBestScore])
        {
            [[Configuration GetSingleton] WriteBestScore:m_CurrentCount];
        }
        
        [[Configuration GetSingleton] ReportScore];
        
        [sender setBackgroundColor:[UIColor redColor]];
        NSString *msg = [NSString stringWithFormat:@"Your result is: %li/100", (long)m_CurrentCount];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GAME OVER" message:msg delegate:self  cancelButtonTitle:@"OK"  otherButtonTitles:@"Facebook" ,nil];
         alert.tag = 101;
         [alert show];
    }
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


- (IBAction)PlayClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    m_CountPlay ++;
    
    if (m_State == PLAYING || m_State == GAMEOVER)
    {
        NSInteger i = 0;
        m_CurrentCount = 0;
        m_State = PREPAREPLAY;
        
        for (UIButton *MyNumber in m_Array100Number)
        {
            MyNumber.enabled = TRUE;
            MyNumber.tag = i++;
            [MyNumber setBackgroundColor:[UIColor darkGrayColor]];
        }
        
    }

    
    if(m_CountPlay >= 5)
    {
        NSLog(@"Count Play 1:  %li", m_CountPlay);
        m_CountPlay = 0;
        [[GADMasterViewController GetSingleton] ResetAdInterstitialView:self];
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 100 && buttonIndex == 1)
    {
        //code for opening settings app in iOS 8
        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    }
    
    if (alertView.tag == 101 && buttonIndex == 1)
    {
        [self ShareFBClick:nil];
    }
    else
    {
        [[GADMasterViewController GetSingleton] ResetAdInterstitialView:self];
    }
}


- (IBAction)RateClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
#else
    
    NSString *MyApp =[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", YOUR_APP_ID];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        NSLog(@"VAo day");
        MyApp = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", YOUR_APP_ID];
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MyApp]];
#endif
}

- (IBAction)GameCenter:(id)sender
{
    NSLog(@"Game Center");
    [[SoundController GetSingleton] PlayClickButton];
    [self presentViewController:[[GCViewController GetSingleton] GetGCView] animated:YES completion:nil];
}
-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)ShareFBClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController
                                            composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString *l_score = [NSString stringWithFormat:@"I got %li boxes in #Complete 100 Boxes", (long)m_CurrentCount];
        
        [fbSheet setInitialText:l_score];
        //NSString *l_url = [NSString stringWithFormat:@"%@%@",@"https://itunes.apple.com/app/id", YOUR_APP_ID];
        //[fbSheet addURL:[NSURL URLWithString:l_url]];
        [fbSheet addImage:[self TakeScreenshot]];
        
        
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SegueAbout"])
    {
        AboutViewController *MyAbout = (AboutViewController *)[segue destinationViewController];
        [MyAbout SetArrayNumber:m_Array100Number];
    }
    
}

@end
