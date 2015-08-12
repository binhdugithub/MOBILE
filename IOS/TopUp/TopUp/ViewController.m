//
//  ViewController.m
//  TopUp
//
//  Created by Nguyễn Thế Bình on 8/10/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSInteger m_index;
}

@property (weak, nonatomic) IBOutlet UIButton *BtnCaptureCard;
@property (weak, nonatomic) IBOutlet UIImageView* cameraImageView;
@property (strong, nonatomic) AVCaptureDevice* device;
@property (strong, nonatomic) AVCaptureSession* captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer* previewLayer;
@property (strong, nonatomic) UIImage* cameraImage;
@property (weak, nonatomic) IBOutlet UITextField *LblCardNumber;
@property (weak, nonatomic) IBOutlet UITextView *TVCardNumber;

@end

@implementation ViewController
@synthesize BtnCaptureCard;
@synthesize LblCardNumber, TVCardNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupCamera];
    [self setupTimer];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    NSLog(@"Width: %f Height: %f", W, H);
    CGRect frm;
    frm.size.width = W;
    frm.size.height = H;
    frm.origin.x = 0;
    frm.origin.y = 0;
    BtnCaptureCard.frame = frm;
    
    //LblCardNumber
    LblCardNumber.hidden = TRUE;
    LblCardNumber.delegate =self;
    
    m_index = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)ClickCaptureCard:(id)sender
{
    if(m_index % 2 == 0)
    {
        NSLog(@"SNAPSHOT");
        self.cameraImageView.image = self.cameraImage;  // Comment-out to hide snapshot
        LblCardNumber.hidden = FALSE;
        
        TVCardNumber.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        TVCardNumber.hidden = FALSE;
        TVCardNumber.editable=NO;
        
        //NSString *phoneNumber = [@"telprompt://" stringByAppendingString:LblCardNumber.text];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
        //NSURL *l_url = [NSURL URLWithString:@"tel://234234232"];
        //[[UIApplication sharedApplication] openURL:(l_url)];
        
        
//        NSString* phoneNumber= LblCardNumber.text;
//        NSString *number = [NSString stringWithFormat:@"%@",phoneNumber];
//        NSURL* callUrl=[NSURL URLWithString:[NSString   stringWithFormat:@"tel:%@",number]];
//        
//        //check  Call Function available only in iphone
//        if([[UIApplication sharedApplication] canOpenURL:callUrl])
//        {
//            BOOL l_ok = [[UIApplication sharedApplication] openURL:callUrl];
//            if (!l_ok) {
//                NSLog(@"Cannot open URL");
//            }
//            else
//                NSLog(@"Open URL OK");
//        }
//        else
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"ALERT" message:@"This function is only available on the iPhone"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            //[alert release];
//        }
        
    }
    else
    {
        NSLog(@"Vao");
        self.cameraImageView.image = [UIImage imageNamed:@"bg_main.png"];
        LblCardNumber.hidden = TRUE;
        TVCardNumber.hidden = TRUE;
    }
    
    m_index++;
}

- (void)setupCamera
{
    NSArray* devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *device in devices)
    {
        //if([device position] == AVCaptureDevicePositionFront)
        if([device position] == AVCaptureDevicePositionBack)
            self.device = device;
    }
    
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
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
        
        self.captureSession = [[AVCaptureSession alloc] init];
        [self.captureSession addInput:input];
        [self.captureSession addOutput:output];
        [self.captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
        
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        //self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        // CHECK FOR YOUR APP
        self.previewLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //self.previewLayer.orientation = AVCaptureVideoOrientationLandscapeRight;
        self.previewLayer.orientation = AVCaptureVideoOrientationPortrait;
        // CHECK FOR YOUR APP
        
        [self.view.layer insertSublayer:self.previewLayer atIndex:0];   // Comment-out to hide preview layer
        
        [self.captureSession startRunning];
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
    
    //self.cameraImage = [UIImage imageWithCGImage:newImage scale:1.0f orientation:UIImageOrientationLeftMirrored];
    self.cameraImage = [UIImage imageWithCGImage:newImage scale:1.0f orientation:UIImageOrientationRight];
    
    CGImageRelease(newImage);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
}

- (void)setupTimer
{
    //NSTimer* cameraTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(snapshot) userInfo:nil repeats:YES];
}

- (void)snapshot
{
    if(m_index % 2 == 0)
    {
        NSLog(@"SNAPSHOT");
        self.cameraImageView.image = self.cameraImage;  // Comment-out to hide snapshot
        
    }
    else
    {
        NSLog(@"Vao");
        self.cameraImageView.image = [UIImage imageNamed:@"bg_main.png"];
    }

    m_index++;
}

@end
