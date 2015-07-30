//
//  Configuration.h
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 7/18/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject
{
    BOOL m_IsMute;
}

+(instancetype) GetSingleton;
- (void) WriteMute : (BOOL) p_ismute;
- (BOOL) GetIsMute;
@end
