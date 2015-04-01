//
//  MyIcon.h
//  Correct
//
//  Created by Nguyễn Thế Bình on 3/23/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface MyIcon : UIImageView
{
    NSInteger m_state;
    UIImage *m_normalIMage;
    UIImage *m_notCorrectedImage;
    UIImage *m_correctingImage;
    UIImage *m_suggestImage;
}

enum STATEICON
{
    NORMAL,
    NOTCORRECTED,
    CORRECTING,
    SUGGEST,
    CORRECTED,
    CORRECTFAIL,
    HIDEN
};

- (void)SetNormalImage: (UIImage *)p_n NotCorectedImage: (UIImage *)p_notc CorrectingImage: (UIImage*)p_c SuggestImage: (UIImage *)p_s;
- (NSInteger)GetStateIcon;
- (void)SetStateIcon: (NSInteger)p_state;
- (void)MoveToX: (CGFloat)x ToY: (CGFloat)y;
- (void)CloneDataFrom :(MyIcon *) p_icon;
- (UIImage*)GetNormalImage;
- (NSInteger)GetTag;


@end


