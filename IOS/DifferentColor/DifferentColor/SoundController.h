//
//  SoundController.h
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundController : NSObject
{
    
}

+(instancetype) GetSingleton;
- (void) PlayClickButton;
- (void) PlaySoundGameOver;
- (void) PlaySoundCongratulation;
- (void) PlaySoundCorrect;
- (void) ChangeMute;
- (BOOL) GetMute;

@end
