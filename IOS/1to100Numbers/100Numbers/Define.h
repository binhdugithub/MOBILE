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

//#define H_FOOTER (if(SCREEN_HEIGHT <= 400){32;}else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720){50;}else if(SCREEN_HEIGHT > 72){90;})

#define W_ICON   1.0/12
#define H_ICON   1.0/12

#define H_BTNPLAY 1.0/7
#define W_BTNPLAY 3.0/4

#define H_YOURSCORE 1.0/5
#define H_3BUTTONS  1.0/3



#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA           ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH   (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH   (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5         (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6         (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P        (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD_1X          (IS_IPAD && (SCREEN_MAX_LENGTH == 512))  //768 x 1024 IPAD2, IPAD mini 1x
#define IS_IPAD_2X          (IS_IPAD && (SCREEN_MAX_LENGTH == 1024)) //1536 x 2048 IPAD, IPADmini 2x
#define IS_IPAD_PRO         (IS_IPAD && (SCREEN_MAX_LENGTH == 1366)) //IPAD pro

#endif
