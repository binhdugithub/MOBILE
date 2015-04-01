//
//  ResultViewController.m
//  Correct
//
//  Created by Nguyễn Thế Bình on 3/31/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "ResultViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Social/Social.h>

@interface ResultViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *m_UIImageViewBg;

@property (weak, nonatomic) IBOutlet UIImageView *m_UIIimageViewLevel;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTime;
@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonNext;

@property (nonatomic, assign) NSInteger m_score;
@property (nonatomic, assign) NSInteger m_currentTime;
@property (nonatomic, assign) NSInteger m_level;
@property (nonatomic, assign) BOOL m_IsMute;

@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayer;

@end

@implementation ResultViewController
@synthesize m_UIImageViewBg, m_UIIimageViewLevel, m_UILabelTime;
@synthesize m_level, m_score, m_currentTime, m_IsMute;
@synthesize m_AudioPlayer;
@synthesize m_UIButtonNext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self InitGUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)InitGUI
{
    if (m_score == 20) {
        m_UIImageViewBg.image = [UIImage imageNamed:@"bg_win.png"];
    }
    else{
        m_UIImageViewBg.image = [UIImage imageNamed:@"bg_lose.png"];
        m_UIButtonNext.hidden = TRUE;
    }
    
    m_UIIimageViewLevel.image =
    [UIImage imageNamed:[NSString stringWithFormat:@"level_%ld.png", (long)m_level]];
    
    m_UILabelTime.text = [NSString stringWithFormat:@"%ld", (long)m_currentTime];
    
    
}

- (IBAction)ShareFacebook:(id)sender
{
    [self PlaySoundClick];
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


- (IBAction)Replay:(id)sender
{
}

- (IBAction)NextLevel:(id)sender
{
    NSString *pathData = [[NSBundle mainBundle]
                          pathForResource: @"Data"
                          ofType:@"plist"] ;
    
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData] ;
    
    if (dicData != nil)
    {
        m_level += 1;
        [dicData setObject:[NSNumber numberWithLong:m_level] forKey:@"Level"];
        [dicData writeToFile:pathData atomically:YES];
    }
    else
    {
        NSLog(@"Save level fail!!");
    }

}

- (void) PlaySoundClick
{
    if(m_IsMute)
        return;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
    NSURL *mp3URL = [NSURL fileURLWithPath:path];
    m_AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    [m_AudioPlayer play];
}


- (void) SetLevel: (NSInteger)p_level
{
    m_level = p_level;
}
- (void) SetScore: (NSInteger)p_score
{
    m_score = p_score;
}
- (void) SetIsMute: (BOOL)p_ismute;
{
    m_IsMute = p_ismute;
}
- (void) SetCurrentTime: (NSInteger)p_time
{
    m_currentTime = p_time;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self PlaySoundClick];
}


@end
