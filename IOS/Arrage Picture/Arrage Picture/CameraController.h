//
//  CameraController.h
//  Match Picture Puzzle
//
//  Created by Nguyễn Thế Bình on 8/28/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "Define.h"

@interface CameraController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    BOOL m_IsRunning;
}

+(instancetype) GetSingleton;
- (void)SetupCamera : (UIView*)p_view;
- (void)StopCamera;
- (void)StopCamera : (UIView*)p_view;
- (BOOL)IsRunning;
- (UIImage*)GetLastImage;

- (UIImage*)GetChooseImage;
- (void)TakePhoto;

@end
