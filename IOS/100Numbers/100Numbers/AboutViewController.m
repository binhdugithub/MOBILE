//
//  AboutViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

@import GoogleMobileAds;

#import "AboutViewController.h"
#import "SoundController.h"
#import "Define.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet GADBannerView *m_UIViewAdvertisement;
@end

@implementation AboutViewController
@synthesize m_UIViewAdvertisement;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self SetupAdvertisementFooter];
}

- (void) SetupAdvertisementFooter
{
    self.m_UIViewAdvertisement.adUnitID = AMOD_BANNER_FOOTER_UNIT;
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
    [[SoundController GetSingleton] PlayClickButton];
}
- (IBAction)RemoveAdsClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}
- (IBAction)RestoreClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}
- (IBAction)m_MoreApp:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
