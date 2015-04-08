//
//  AboutViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

@import GoogleMobileAds;

#import "AboutViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SoundController.h"

@interface AboutViewController ()
@property (nonatomic, strong) SoundController *m_Sounder;
@property (weak, nonatomic) IBOutlet GADBannerView *m_UIViewAdvertisement;
@end

@implementation AboutViewController
@synthesize m_Sounder;
@synthesize m_UIViewAdvertisement;

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_Sounder = [[SoundController alloc] init];
    // Do any additional setup after loading the view.
    
    self.m_UIViewAdvertisement.adUnitID = @"ca-app-pub-2735696870763171/1666550849";
    self.m_UIViewAdvertisement.rootViewController = self;
    [self.m_UIViewAdvertisement loadRequest:[GADRequest request]];
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
