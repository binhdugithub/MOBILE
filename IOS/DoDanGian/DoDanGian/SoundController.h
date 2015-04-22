//
//  SoundController.h
//  100Perfect
//
//  Created by Nguyễn Thế Bình on 4/18/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
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