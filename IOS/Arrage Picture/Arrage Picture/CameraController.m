//
//  CameraController.m
//  Match Picture Puzzle
//
//  Created by Nguyễn Thế Bình on 8/28/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "CameraController.h"

@interface CameraController()
{
    
}

@property (strong, nonatomic) AVCaptureDevice* m_Device;
@property (strong, nonatomic) AVCaptureSession* m_CaptureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer* m_PreviewLayer;
@property (strong, nonatomic) UIImage* m_CameraImage;
@property (strong, nonatomic) UIImage* m_ChooseImage;

@end


@implementation CameraController
@synthesize m_Device, m_CaptureSession, m_PreviewLayer, m_CameraImage,m_ChooseImage;

+(instancetype) GetSingleton
{
    static CameraController *ShareObject = nil ;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        ShareObject = [[CameraController alloc] init] ;
    });
    
    return ShareObject ;
}


-(id)init
{
    
    self = [super init];
    if(self)
    {
        m_CaptureSession = nil;
        m_Device = nil;
        m_IsRunning = FALSE;
        m_ChooseImage = nil;
    }
    
    return self;
}

- (UIImage*)GetLastImage
{
    return m_CameraImage;
}


- (UIImage*)GetChooseImage
{
    return m_ChooseImage;
}


- (void)StopCamera
{
    if (m_CaptureSession != nil)
    {
        [m_CaptureSession stopRunning];
        m_CaptureSession = nil;
        [m_PreviewLayer removeFromSuperlayer];
        
        m_IsRunning = FALSE;
    }
}

- (void)StopCamera : (UIView*)p_view
{
    if (m_CaptureSession != nil)
    {
        [m_CaptureSession stopRunning];
        m_CaptureSession = nil;
        [m_PreviewLayer removeFromSuperlayer];
        
        m_IsRunning = FALSE;
    }
}

- (BOOL)IsRunning
{
    return m_IsRunning;
}

- (void)SetupCamera : (UIView*)p_view
{
    NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *device in devices)
    {
        //if([device position] == AVCaptureDevicePositionFront)
        if([device position] == AVCaptureDevicePositionBack)
            m_Device = device;
    }
    
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:m_Device error:nil];
    if(input != nil)
    {
        AVCaptureVideoDataOutput* output = [[AVCaptureVideoDataOutput alloc] init];
        output.alwaysDiscardsLateVideoFrames = YES;
        
        dispatch_queue_t queue;
        queue = dispatch_queue_create("cameraQueue", NULL);
        [output setSampleBufferDelegate:self queue:queue];
        
        NSString* key = (NSString *) kCVPixelBufferPixelFormatTypeKey;
        NSNumber* value = [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA];
        NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:value forKey:key];
        [output setVideoSettings:videoSettings];
        
        m_CaptureSession = [[AVCaptureSession alloc] init];
        [m_CaptureSession addInput:input];
        [m_CaptureSession addOutput:output];
        [m_CaptureSession setSessionPreset:AVCaptureSessionPresetPhoto];
        
        m_PreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:m_CaptureSession];
        //self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        //m_PreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        // CHECK FOR YOUR APP
        m_PreviewLayer.frame = CGRectMake(0, 0, p_view.frame.size.width, p_view.frame.size.height);
        m_PreviewLayer.orientation = AVCaptureVideoOrientationPortrait;
        // CHECK FOR YOUR APP
        [p_view.layer insertSublayer: m_PreviewLayer atIndex:0];   // Comment-out to hide preview layer
        [m_CaptureSession startRunning];
        
        m_IsRunning = TRUE;
        
    }else
    {
        NSLog(@"AVCaptureDeviceInput is nil");
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    
    CGContextRelease(newContext);
    CGColorSpaceRelease(colorSpace);
    
    m_CameraImage = [UIImage imageWithCGImage:newImage scale:1.0f orientation:UIImageOrientationRight];
    //m_CameraImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
}




//Picker
- (void)TakePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    m_ChooseImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
