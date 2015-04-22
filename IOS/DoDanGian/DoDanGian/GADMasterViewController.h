//
//  GADMasterViewController.h
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/18/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
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
}

+(GADMasterViewController *)singleton;
-(id)init;

-(void)resetAdBannerView:(UIViewController *)rootViewController;
-(void)resetAdBannerView:(UIViewController *)rootViewController AtFrame:(CGRect) frm;


@end