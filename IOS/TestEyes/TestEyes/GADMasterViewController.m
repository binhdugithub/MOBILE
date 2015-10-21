//
//  GADMasterViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/12/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "GADMasterViewController.h"

@implementation GADMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



+(GADMasterViewController *)GetSingleton
{
    static dispatch_once_t pred;
    static GADMasterViewController *shared;
    
    // Will only be run once, the first time this is called
    dispatch_once(&pred, ^
                  {
                      NSLog(@"GADMaster:GetSingeton");
                      shared = [[GADMasterViewController alloc] init];
                  });
    return shared;
}


-(id)init
{
    NSLog(@"GADMaster:Init");
    if (self = [super init])
    {
        // Has an ad request already been made
        m_Banner = [[GADBannerView alloc] init];
        m_IsLoaded = NO;
        
        [self GetInterstitialAds];
    }
    
    
    return self;
}


-(void)resetAdBannerView:(UIViewController *)p_RootViewController AtFrame:(CGRect) frm
{
    NSLog(@"GADMaster:resetAdBannerView with frame:%f-%f", frm.size.width, frm.size.height);
    
    m_Banner.frame = frm;
    
    // Ad already requested, simply add it into the view
    if (m_IsLoaded)
    {
        [p_RootViewController.view addSubview:m_Banner];
    }
    else
    {
        m_Banner.delegate = self;
        m_Banner.rootViewController = p_RootViewController;
        m_Banner.adUnitID = AMOD_BANNER_FOOTER_UNIT;
        
        GADRequest *request = [GADRequest request];
        //request.testDevices = @[ @"15b5d334e2e980a8595f943d3fe28621" ];
        [m_Banner loadRequest:request];
        [p_RootViewController.view addSubview:m_Banner];
        //m_IsLoaded = YES;
    }
}

- (void)GetInterstitialAds
{
    NSLog(@"GADMaster:GetInterstitialAds");
    m_Interstitial = [[GADInterstitial alloc] initWithAdUnitID:AMOD_INTERSTITIAL_UNIT];
    m_Interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    //request.testDevices = @[ @"15b5d334e2e980a8595f943d3fe28621" ];
    [m_Interstitial loadRequest:request];
}

-(void)ResetAdInterstitialView:(UIViewController *)rootViewController
{
    NSLog(@"GADMaster:ResetAdInterstitialView");
    if([m_Interstitial hasBeenUsed])
    {
        NSLog(@"GADMaster:Interstitial has been used");
        //return;
    }
    else if([m_Interstitial isReady])
    {
        [m_Interstitial presentFromRootViewController:rootViewController];
    }
    else
    {
        NSLog(@"GADInterstitial not ready");
        [self GetInterstitialAds];
    }
    
}

#pragma GADDelegate
- (void)interstitialDidDismissScreen:(GADInterstitial *)p_interstitial
{
    NSLog(@"GADMaster:DidDismissinterstitial");
    [self GetInterstitialAds];
}

- (void)adViewDidReceiveAd:(GADBannerView *)adView
{
    NSLog(@"GADMaster:adViewDidReceiveAd");
    
    adView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        adView.alpha = 1;
    }];
    
    m_IsLoaded = TRUE;
    
}

- (void) adViewWillDismissScreen:(GADBannerView *)bannerView
{
    NSLog(@"GADMaster:adViewWillDismissScreen");
    m_IsLoaded = FALSE;
}

- (void) adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
    m_IsLoaded = FALSE;
}

- (void) adViewWillPresentScreen:(GADBannerView *)bannerView
{
    NSLog(@"adViewWillPresentScreen");
}

@end
