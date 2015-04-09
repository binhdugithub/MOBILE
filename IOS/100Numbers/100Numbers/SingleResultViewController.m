//
//  1ResultViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

@import GoogleMobileAds;

#import "SingleResultViewController.h"
#import "SinglePlayerViewController.h"
#import "StatisticsViewController.h"
#import "SoundController.h"
#import <Social/Social.h>


@interface SingleResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelScore;


@property (nonatomic, strong)NSMutableArray *m_Array100Number;
@property (nonatomic, assign)NSInteger m_CurrentNumber;

@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation SingleResultViewController
@synthesize m_UILabelScore;
@synthesize m_Array100Number;
@synthesize m_CurrentNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Advertisement
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = @"ca-app-pub-2735696870763171/8572538847";
    [self.interstitial loadRequest:[GADRequest request]];
    //End Advertisement
    
    [m_UILabelScore setText:[NSString stringWithFormat:@"%li / 100", (long)m_CurrentNumber]];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                target:self
                                selector:@selector(ShowAdvertisement:)
                                userInfo:nil
                                repeats:NO];
}

- (void) ShowAdvertisement: (NSTimer*)p_timer
{
    if ([self.interstitial isReady])
    {
        
        [self.interstitial presentFromRootViewController:self];
        
    }else
    {
        NSLog(@"GADInterstitial not ready");
    }
    
    
    [p_timer invalidate];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *pathData = [[NSBundle mainBundle] pathForResource: @"Data" ofType:@"plist"];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData];
    
    if (dicData != nil)
    {
        NSInteger l_timesPlayed = [dicData[@"TimesPlayed"] intValue];
        NSInteger l_NewAverage = ([dicData[@"AverageScore"] intValue] * l_timesPlayed + m_CurrentNumber ) / (l_timesPlayed + 1);
        
        [dicData setObject:[NSNumber numberWithInt:l_NewAverage] forKey:@"AverageScore"];
        [dicData setObject:[NSNumber numberWithInt:(l_timesPlayed + 1)] forKey:@"TimesPlayed"];
        if (m_CurrentNumber > [dicData[@"BestScore"] intValue])
        {
            [dicData setObject:[NSNumber numberWithInt: m_CurrentNumber] forKey:@"BestScore"];
        }
        
        [dicData writeToFile:pathData atomically:YES];

    }
    else
    {
        NSLog(@"Load User info fail !!");
    }
    
    
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
