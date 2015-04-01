//
//  ResultViewController.h
//  Correct
//
//  Created by Nguyễn Thế Bình on 3/31/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
{
    
}

- (void) SetLevel: (NSInteger)p_level;
- (void) SetScore: (NSInteger)p_score;
- (void) SetIsMute: (BOOL)p_ismute;
- (void) SetCurrentTime: (NSInteger)p_time;
@end
