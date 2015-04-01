//
//  AboutViewController.m
//  Correct
//
//  Created by Binh Du  on 3/29/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AboutViewController ()
@property (nonatomic, strong) AVAudioPlayer* m_AudioPlayer;
@property (nonatomic, assign) BOOL m_IsMute;
@end

@implementation AboutViewController
@synthesize m_AudioPlayer;
@synthesize m_IsMute;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1. Init background
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) PlaySoundClick
{
    if (m_IsMute)
        return;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
    NSURL *mp3URL = [NSURL fileURLWithPath:path];
    m_AudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL error:NULL];
    [m_AudioPlayer play];
}

- (void)SetMuteState:(BOOL)p_state
{
    m_IsMute = p_state;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"SegueHome"] )
    {
        [self PlaySoundClick];
    }
}


@end
