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

@interface StatisticsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelBestScore;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelAverageScore;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTimesPlayed;


@property (nonatomic, strong)NSMutableArray *m_Array100Number;
@end

@implementation StatisticsViewController
@synthesize m_UILabelAverageScore, m_UILabelBestScore, m_UILabelTimesPlayed;
@synthesize m_Array100Number;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self LoadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)LoadData
{
    NSString *pathData = [[NSBundle mainBundle] pathForResource: @"Data" ofType:@"plist"];
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        NSInteger l_timesPlayed = [dicData[@"TimesPlayed"] intValue];
        if (l_timesPlayed <= 0)
        {
            m_UILabelBestScore.text = @"--";
            m_UILabelAverageScore.text = @"--";
            m_UILabelTimesPlayed.text = @"--";
        }
        else
        {
           
            m_UILabelBestScore.text = [NSString stringWithFormat:@"%i / 100",
                                       [dicData[@"BestScore"] intValue]];
            m_UILabelAverageScore.text = [NSString stringWithFormat:@"%i",
                                       [dicData[@"AverageScore"] intValue]];
             m_UILabelTimesPlayed.text = [NSString stringWithFormat:@"%i", l_timesPlayed];
        }
        
    }
    else
    {
        NSLog(@"Load User info fail !!");
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
        NSString *pathData = [[NSBundle mainBundle]
                              pathForResource: @"Data"
                              ofType:@"plist"] ;
        
        NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData] ;
        
        if (dicData != nil)
        {
            [dicData setObject:[NSNumber numberWithInt:0] forKey:@"BestScore"];
            [dicData setObject:[NSNumber numberWithInt:0] forKey:@"AverageScore"];
            [dicData setObject:[NSNumber numberWithInt:0] forKey:@"TimesPlayed"];
            [dicData writeToFile:pathData atomically:YES];
        }
        else
        {
            NSLog(@"Save ismute fail!!");
        }
        
        m_UILabelBestScore.text = @"--";
        m_UILabelAverageScore.text = @"--";
        m_UILabelTimesPlayed.text = @"--";
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
