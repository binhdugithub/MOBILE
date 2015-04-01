//
//  ViewController.m
//  Correct
//
//  Created by Binh Du  on 3/22/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "HomeViewController.h"
#import "PlayViewController.h"
#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *m_uiimgScreenShot;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnPlay;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnAbout;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnMute;
@property (nonatomic, assign) BOOL m_IsMute;
@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayer;

@end

@implementation HomeViewController

@synthesize m_AudioPlayer;
@synthesize m_uiimgScreenShot,
            m_BtnAbout,
            m_BtnMute,
            m_BtnPlay,
            m_IsMute;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self SetBackgroundWithRed:9 Green:65 Blue:28];
    
    [self LoadData];
    [self ShowSpeakerBackground];
}

- (void)LoadData
{
    NSString *pathData = [[NSBundle mainBundle] pathForResource: @"Data" ofType:@"plist"];
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        m_IsMute = [dicData[@"IsMute"] boolValue];
        NSLog(@"m_IsMute: %i", m_IsMute);
    }
    else
    {
        NSLog(@"Load User info fail !!");
    }
}

-(void)WriteStatusMuting
{
    NSString *pathData = [[NSBundle mainBundle]
                          pathForResource: @"Data"
                          ofType:@"plist"] ;
    
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:pathData] ;
    
    if (dicData != nil)
    {
        
        [dicData setObject:[NSNumber numberWithInt:m_IsMute] forKey:@"IsMute"];
        [dicData writeToFile:pathData atomically:YES];
    }
    else
    {
        NSLog(@"Save ismute fail!!");
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

/*
- (void)RotationClock
{
    m_currentTime ++;
    [UIView beginAnimations:nil context:NULL];
    {
        [UIView setAnimationDuration:0.5];
        //[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationDelegate:self];
        m_uiimgScreenShot.transform = CGAffineTransformMakeRotation(m_currentTime * 6 * M_PI / 180);
    }
    [UIView commitAnimations];
    
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"step1"])
    {
        [UIView beginAnimations:@"step2" context:NULL];
        {
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            [UIView setAnimationDelegate:self];
            m_uiimgScreenShot.transform = CGAffineTransformMakeRotation(240 * M_PI / 180);
        }
        [UIView commitAnimations];
    }
    else if ([animationID isEqualToString:@"step2"])
    {
        [UIView beginAnimations:@"step3" context:NULL];
        {
            [UIView setAnimationDuration:1.0];
            [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
            [UIView setAnimationDelegate:self];
            m_uiimgScreenShot.transform = CGAffineTransformMakeRotation(0);
        }
        [UIView commitAnimations];
    }
}

*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                                  
- (void)SetBackgroundWithRed: (NSInteger)p_r Green:(NSInteger)p_g Blue:(NSInteger)p_b
{
    UIColor *MyBackgroundColor = [UIColor colorWithRed:p_r/255.0 green:p_g/255.0 blue:p_b/255.0 alpha:1];
    self.view.backgroundColor = MyBackgroundColor;
}

- (void)ShowSpeakerBackground
{
    if (m_IsMute) {
        [m_BtnMute setImage:[UIImage imageNamed:@"btn_mute.png"] forState:UIControlStateNormal];
    }
    else{
        [m_BtnMute setImage:[UIImage imageNamed:@"btn_unmute.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)MuteClick:(id)sender
{
    [self PlaySoundClick];
    m_IsMute = (m_IsMute)? FALSE : TRUE;
    [self WriteStatusMuting];
    [self ShowSpeakerBackground];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SegueAbout"] )
    {
        [self PlaySoundClick];
         AboutViewController *MyAboutView = (AboutViewController*)[segue destinationViewController];
        [MyAboutView SetMuteState:m_IsMute];
    }
    
    if ([[segue identifier] isEqualToString:@"SeguePlay"])
    {
        [self PlaySoundClick];
        PlayViewController *MyPlayView = (PlayViewController*)[segue destinationViewController];
        [MyPlayView SetMuteState:m_IsMute];
    }
}

#pragma mark - imageRotatedByDegrees Method

- (UIImage *)imageRotatedByDegrees:(UIImage*)oldImage deg:(CGFloat)degrees{
    
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(60,80,200, 200)];
    
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * M_PI / 180));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

@end
