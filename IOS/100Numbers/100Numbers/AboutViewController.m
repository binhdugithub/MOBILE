//
//  AboutViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SoundController.h"

@interface AboutViewController ()
@property (nonatomic, strong) SoundController *m_Sounder;
@end

@implementation AboutViewController
@synthesize m_Sounder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_Sounder = [[SoundController alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)HomeClick:(id)sender
{
    [m_Sounder PlayClickButton];
}
- (IBAction)RemoveAdsClick:(id)sender
{
    [m_Sounder PlayClickButton];
}
- (IBAction)RestoreClick:(id)sender
{
    [m_Sounder PlayClickButton];
}
- (IBAction)m_MoreApp:(id)sender
{
    [m_Sounder PlayClickButton];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
