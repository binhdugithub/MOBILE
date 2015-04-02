//
//  1PlayerViewController.h
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePlayerViewController : UIViewController
{
    
}

enum STATEGAME
{
    FIRSTWIEW,
    BACKVIEW,
    PREPAREPLAY,
    PLAYING
};

- (void)NumberClick: (UIButton*)sender;
- (void)SetStateGame: (NSInteger) p_state;
- (void)SetArrayNumber: (NSMutableArray*) p_array;
@end
