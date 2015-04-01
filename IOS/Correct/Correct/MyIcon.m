//
//  MyIcon.m
//  Correct
//
//  Created by Nguyễn Thế Bình on 3/23/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "MyIcon.h"

@implementation MyIcon


-(id)init
{
    
    self = [super init];
    if(self)
    {
        m_state = -1;
        
    }
    
    return self;
}

- (NSInteger)GetStateIcon
{
    return m_state;
}

- (void)SetStateIcon: (NSInteger) p_state
{
    if (m_state == p_state)
        return;
    
    m_state = p_state;
    switch (p_state)
    {
        case CORRECTED:
        case NORMAL:
            [self setImage:m_normalIMage];
            //[self SetImageSlowly:m_normalIMage];
            break;
        case NOTCORRECTED:
            [self setImage:m_notCorrectedImage];
            //[self SetImageSlowly:m_notCorrectedImage];
            break;
        case CORRECTING:
            [self setImage:m_correctingImage];
            //[self SetImageSlowly:m_correctingImage];
            break;
        case HIDEN:
            //[self MoveToX: -1000 ToY:-1000];
            //m_position = -1;
            //[self setFrame:CGRectMake(-1000, -1000, [self frame].size.width, [self frame].size.height)];
            break;
        case SUGGEST:
            [self setImage:m_suggestImage];
            break;
            
        default:
            break;
    }
}

- (void)SetImageSlowly: (UIImage *)image
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0];
    [self setImage:image];
    [UIView commitAnimations];
}


- (void)SetNormalImage: (UIImage *)p_n NotCorectedImage: (UIImage *)p_notc CorrectingImage: (UIImage*)p_c SuggestImage: (UIImage *)p_s;
{
    m_normalIMage = p_n;
    m_notCorrectedImage = p_notc;
    m_correctingImage = p_c;
    m_suggestImage = p_s;
}

- (void)MoveToX: (CGFloat)x ToY: (CGFloat)y
{
    
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGRect frameIcon = self.frame;
        frameIcon.origin.x = x;
        frameIcon.origin.y = y;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        self.frame = frameIcon;
        [UIView commitAnimations];
  //  });

}



- (UIImage*)GetNormalImage
{
    return m_normalIMage;
}

- (NSInteger)GetTag
{
    return self.tag;
}


- (void)CloneDataFrom :(MyIcon *) p_icon
{
    m_state = -1;
    self.tag = p_icon.tag;
    m_normalIMage =[p_icon GetNormalImage] ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
