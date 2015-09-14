//
//  GADMasterViewController.h
//  100Numbers
//
//  Created by Binh Du  on 4/12/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//
@import GoogleMobileAds;
#import <UIKit/UIKit.h>
#include "Define.h"

@interface GADMasterViewController : UIViewController<GADBannerViewDelegate, GADInterstitialDelegate>
{
    GADBannerView *adBanner_;
    BOOL didCloseWebsiteView_;
    BOOL isLoaded_;
    id currentDelegate_;
    
    GADInterstitial *interstitial;
}

+(GADMasterViewController *)GetSingleton;
-(id)init;

-(void)resetAdBannerView:(UIViewController *)rootViewController;
-(void)resetAdBannerView:(UIViewController *)rootViewController AtFrame:(CGRect) frm;
- (void)GetInterstitialAds;
-(void)ResetAdInterstitialView:(UIViewController *)rootViewController;


@end
