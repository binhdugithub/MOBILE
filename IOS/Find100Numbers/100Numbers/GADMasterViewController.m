//
//  GADMasterViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/12/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "GADMasterViewController.h"

@implementation GADMasterViewController

+(GADMasterViewController *)GetSingleton
{
    static dispatch_once_t pred;
    static GADMasterViewController *shared;
    // Will only be run once, the first time this is called
    dispatch_once(&pred, ^{
        shared = [[GADMasterViewController alloc] init];
    });
    return shared;
}


-(id)init
{
    if (self = [super init])
    {
        adBanner_ = [[GADBannerView alloc]
                     initWithFrame:CGRectMake(0.0,
                                              0.0,
                                              GAD_SIZE_320x50.width,
                                              GAD_SIZE_320x50.height)];
        // Has an ad request already been made
        isLoaded_ = NO;
        
        
        [self GetInterstitialAds];
    }
    return self;
}

-(void)resetAdBannerView:(UIViewController *)rootViewController
{
    // Always keep track of currentDelegate for notification forwarding
    currentDelegate_ = rootViewController;
    // Ad already requested, simply add it into the view
    if (isLoaded_)
    {
        [rootViewController.view addSubview:adBanner_];
    }
    else
    {
        
        adBanner_.delegate = self;
        adBanner_.rootViewController = rootViewController;
        adBanner_.adUnitID = AMOD_BANNER_FOOTER_UNIT;
        
        GADRequest *request = [GADRequest request];
        [adBanner_ loadRequest:request];
        [rootViewController.view addSubview:adBanner_];
        isLoaded_ = YES;
    }
}

-(void)resetAdBannerView:(UIViewController *)rootViewController AtFrame:(CGRect) frm
{
    // Always keep track of currentDelegate for notification forwarding
    currentDelegate_ = rootViewController;
    adBanner_.frame = frm;
    
    // Ad already requested, simply add it into the view
    if (isLoaded_)
    {
        [rootViewController.view addSubview:adBanner_];
    }
    else
    {
        adBanner_.delegate = self;
        adBanner_.rootViewController = rootViewController;
        adBanner_.adUnitID = AMOD_BANNER_FOOTER_UNIT;
        
        GADRequest *request = [GADRequest request];
        [adBanner_ loadRequest:request];
        [rootViewController.view addSubview:adBanner_];
        isLoaded_ = YES;
    }
}

- (void)GetInterstitialAds
{
    interstitial = [[GADInterstitial alloc] initWithAdUnitID:AMOD_INTERSTITIAL_UNIT];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
}

-(void)ResetAdInterstitialView:(UIViewController *)rootViewController
{
    if([interstitial isReady])
    {
        [interstitial presentFromRootViewController:rootViewController];
    }
    else
    {
        [self GetInterstitialAds];
        NSLog(@"GADInterstitial not ready");
    }
    
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    NSLog(@"DidDismissinterstitial");
    [self GetInterstitialAds];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[GADMasterViewController singleton] resetAdBannerView:self];
}


- (void)adViewDidReceiveAd:(GADBannerView *)adView
{
    // Make sure that the delegate actually responds to this notification
    if (currentDelegate_)
    {
        //[currentDelegate_ adViewDidReceiveAd:adView];
        
        
    }
    
    adView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        adView.alpha = 1;
    }];
    
}
@end
