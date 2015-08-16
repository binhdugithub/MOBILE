//
//  Define.h
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/18/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#ifndef _00Numbers_Define_h
#define _00Numbers_Define_h

#import "SoundController.h"
#import "GADMasterViewController.h"
#import "Configuration.h"


#define YOUR_APP_ID @"1028819809"
#define FILECONFIG @"/data.plist"


#define AMOD_BANNER_FOOTER_UNIT @"ca-app-pub-2735696870763171/2068646840"
#define AMOD_INTERSTITIAL_UNIT @"ca-app-pub-2735696870763171/3545380042"
#define AMOD_INTERSTITIAL_TIMES_2_SHOW 3
#define AMOD_INTERSTITIAL_TIMEOUT 4

#define TIME_MAX 300

#define H_HEADER 1.0/12
#define H_FOOTER 1.0/10

#define W_ICON_IP4   1.0/11
#define H_ICON_IP4   W_ICON_IP4

#define W_ICON_IP5   1.0/14
#define H_ICON_IP5   W_ICON_IP5

#define H_BTNPLAY 1.0/7
#define W_BTNPLAY 3.0/4

#define H_YOURSCORE 1.0/4
#define H_3BUTTONS  1.0/3


#define NUM_RANDOM_BUTTON 18
#define ALPHABETA @"QWERTYUIOPASDFGHKLXCVBNM"
#define RUBY_FOR_NEXT_LEVEL 30
#define RUBY_FOR_SUGGESTION_CHARACTER 10
#define RUBY_FOR_SHARE  10


#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA           ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS    (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P        (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif

