//
//  Define.h
//  100Numbers
//
//  Created by Binh Du  on 4/12/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#ifndef _00Numbers_Define_h
#define _00Numbers_Define_h


#define YOUR_APP_ID @"1048219569" //1 to 100 Numbers

#define AMOD_BANNER_FOOTER_UNIT @"ca-app-pub-2735696870763171/3085765640"
#define AMOD_INTERSTITIAL_UNIT @"ca-app-pub-2735696870763171/4562498848"
#define AMOD_INTERSTITIAL_TIMEOUT 5

#define FILECONFIG @"/data.plist"
#define TEXT_COPYRIGHT @"CUSIKI @2015"
#define TIME_MAX 300


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
