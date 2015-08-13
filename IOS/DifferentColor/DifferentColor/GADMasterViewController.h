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

@interface GADMasterViewController : UIViewController
{
    GADBannerView *adBanner_;
    BOOL didCloseWebsiteView_;
    BOOL isLoaded_;
    id currentDelegate_;
    
    GADInterstitial *interstitial;
}

+(GADMasterViewController *)singleton;
-(id)init;

-(void)resetAdBannerView:(UIViewController *)rootViewController;
-(void)resetAdBannerView:(UIViewController *)rootViewController AtFrame:(CGRect) frm;
-(void)resetAdInterstitialView:(UIViewController *)rootViewController;


@end
