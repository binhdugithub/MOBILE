//
//  PlayViewController.m
//  Arrage Picture
//
//  Created by Nguyễn Thế Bình on 8/24/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "PlayViewController.h"


#define NUMBER_V_ITEM 4
#define NUMBER_H_ITEM 4
#define TIMEOUT 0


@interface PlayViewController ()
{
    NSMutableArray *m_ArrayUIImageView;
    NSInteger m_CurrentPicture;
    NSInteger m_State;
    NSTimer *m_Timer;
    NSInteger m_CurrentTime;
    
    NSLock *m_lockMain;
    BOOL m_isAnimation;
    
    BOOL m_TypeTakePhoto;
}

@property (weak, nonatomic) IBOutlet UIButton *m_BtnBack;
@property (weak, nonatomic) IBOutlet UILabel *m_LblTime;
@property (weak, nonatomic) IBOutlet UILabel *m_LblBestTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel *m_LblBestTime;


@property (weak, nonatomic) IBOutlet UIView *m_ViewPicture;
@property (weak, nonatomic) IBOutlet UIView *m_ViewHeader;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnSpeaker;
@property (weak, nonatomic) IBOutlet UILabel *m_LblLevel;
@property (strong, nonatomic) UIImageView *m_ImageViewFull;
@property (strong, nonatomic) UIImage    *m_ImageTake;


@property (weak, nonatomic) IBOutlet UIView *m_ViewButton;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnCamera;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnShare;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnReplay;
@property (weak, nonatomic) IBOutlet UIButton *m_BtnNext;


@property (nonatomic, strong) UIView *m_DragObject;
@property (nonatomic, strong) UIView *m_DestinationObject;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;


@end

@implementation PlayViewController
@synthesize m_BtnBack, m_LblLevel, m_LblTime;
@synthesize m_ViewPicture;
@synthesize m_ViewHeader;
@synthesize m_BtnSpeaker;
@synthesize m_DragObject, m_DestinationObject, touchOffset, homePosition;
@synthesize m_ImageViewFull;

@synthesize m_BtnCamera, m_BtnNext, m_BtnReplay, m_BtnShare, m_ViewButton;

@synthesize m_LblBestTime, m_LblBestTimeTitle;
@synthesize m_ImageTake;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self InitGUI];
    [self InitArrayUIImageView];
    [self ShowSpeaker];
   
    m_lockMain = [[NSLock alloc] init];
    m_DragObject = NULL;
    m_DestinationObject = NULL;
    m_isAnimation = FALSE;
    m_TypeTakePhoto = FALSE;
    m_ImageTake = nil;
    [self ShowAdBannerView];
    m_State = PREPAREPLAY;
    [[Configuration GetSingleton] WriteLevel:90];
    [self ShowRandomPicture:[self GetPicutre:[[Configuration GetSingleton] GetLevel]]];
    //[self ShowRandomPicture:[self GetPicutre:90]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)ShowAdBannerView
{
    CGRect frm;
    frm.size.width = SCREEN_WIDTH;
    frm.size.height = 50;
    frm.origin.x = 0;
    frm.origin.y = SCREEN_HEIGHT - 50;
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:frm];
}


- (void)InitGUI
{
    //background
    self.view.backgroundColor = [UIColor colorWithRed:85.0/255 green:137.0/255 blue:125.0/255 alpha:1];
    
    //Header
    CGRect frm;
    frm.size.width = SCREEN_WIDTH;
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.height = 40;
    }
    else if(IS_IPAD)
    {
        frm.size.height = 60;
    }
    else
    {
        frm.size.height = 50;
    }
    
    
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_ViewHeader.frame = frm;
    m_ViewHeader.backgroundColor = [UIColor colorWithRed:66.0/255 green:84.0/255 blue:84.0/255 alpha:1];

    
    //back
    frm.size.width = 1.0/2 * (m_ViewHeader.frame.size.height);
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/2 * frm.size.width;
    frm.origin.y = 1.0/2 * (m_ViewHeader.frame.size.height - frm.size.height);
    m_BtnBack.frame = frm;
    
    //m_LblLevel
    frm.size.width = 1.0/2 * SCREEN_WIDTH;
    frm.size.height = m_ViewHeader.frame.size.height;
    frm.origin.x = 1.0/2 * (m_ViewHeader.frame.size.width - frm.size.width);
    frm.origin.y = 1.0/2 * (m_ViewHeader.frame.size.height - frm.size.height);
    m_LblLevel.frame = frm;
    if(IS_IPAD)
    {
        [m_LblLevel setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        [m_LblLevel setFont:[UIFont systemFontOfSize:16 weight:0.5]];
    }
    else
    {
        [m_LblLevel setFont:[UIFont systemFontOfSize:18 weight:0.5]];
    }
    [m_LblLevel setTextColor:[UIColor whiteColor]];
    [m_LblLevel setTextAlignment:NSTextAlignmentCenter];
    
    //speaker
    frm = m_BtnBack.frame;
    frm.origin.x = m_ViewHeader.frame.size.width - m_BtnBack.frame.size.width - 1.0/2 * m_BtnBack.frame.size.width;
    m_BtnSpeaker.frame = frm;
    
    //subhdear
    frm = m_ViewHeader.frame;
    frm.size.height = 2;
    frm.origin.y = m_ViewHeader.frame.origin.y + m_ViewHeader.frame.size.height;
    UIView *l_subHeader = [[UIView alloc] initWithFrame:frm];
    [self.view addSubview:l_subHeader];
    l_subHeader.backgroundColor = [UIColor colorWithRed:123.0/255 green:86.0/255 blue:79.0/255 alpha:1];
    
    //m_LblTime
    frm.size.width = 1.0/2 * SCREEN_WIDTH;
    frm.size.height = m_ViewHeader.frame.size.height;
    frm.origin.x = 1.0/2 *(SCREEN_WIDTH - frm.size.width);
    if(IS_IPAD)
    {
        frm.origin.y = l_subHeader.frame.origin.y + l_subHeader.frame.size.height + 10;
    }
    else
    {
        frm.origin.y = l_subHeader.frame.origin.y + l_subHeader.frame.size.height;
    }
    
    m_LblTime.frame = frm;
    
    if(IS_IPAD)
    {
        [m_LblTime setFont:[UIFont systemFontOfSize:30 weight:0.5]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        [m_LblTime setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    }
    else
    {
        [m_LblTime setFont:[UIFont systemFontOfSize:25 weight:0.5]];
    }
    
    [m_LblTime setTextColor:[UIColor whiteColor]];
    [m_LblTime setTextAlignment:NSTextAlignmentCenter];
    
    //m_LblBestTimeTitle
    frm.size.width = 1.0/4 * SCREEN_WIDTH;
    frm.size.height = 1.0/2 * m_LblTime.frame.size.height;
    frm.origin.x = (SCREEN_WIDTH - frm.size.width);
    frm.origin.y = m_LblTime.frame.origin.y;
    
    m_LblBestTimeTitle.frame = frm;
    
    if(IS_IPAD)
    {
        [m_LblBestTimeTitle setFont:[UIFont systemFontOfSize:20 weight:0.3]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        [m_LblBestTimeTitle setFont:[UIFont systemFontOfSize:10 weight:0.3]];
    }
    else
    {
        [m_LblBestTimeTitle setFont:[UIFont systemFontOfSize:15 weight:0.3]];
    }
    
    [m_LblBestTimeTitle setTextColor:[UIColor darkGrayColor]];
    [m_LblBestTimeTitle setTextAlignment:NSTextAlignmentCenter];
    
    //m_LblBestTime
    frm = m_LblBestTimeTitle.frame;
    frm.origin.x = (SCREEN_WIDTH - frm.size.width);
    frm.origin.y = m_LblBestTimeTitle.frame.origin.y + m_LblBestTimeTitle.frame.size.height;
    
    m_LblBestTime.frame = frm;
    
    if(IS_IPAD)
    {
        [m_LblBestTime setFont:[UIFont systemFontOfSize:20 weight:0.3]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        [m_LblBestTime setFont:[UIFont systemFontOfSize:10 weight:0.3]];
    }
    else
    {
        [m_LblBestTime setFont:[UIFont systemFontOfSize:15 weight:0.3]];
    }
    
    [m_LblBestTime setTextColor:[UIColor whiteColor]];
    [m_LblBestTime setTextAlignment:NSTextAlignmentCenter];
    m_LblBestTime.text = [NSString stringWithFormat:@"%i", [[Configuration GetSingleton] GetScore]];
    
    //view main
    frm.size.width = SCREEN_WIDTH - 40;
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/2 *(SCREEN_WIDTH - frm.size.width);
    frm.origin.y = m_LblTime.frame.origin.y + m_LblTime.frame.size.height;
    m_ViewPicture.frame = frm;
    
    m_ImageViewFull = [[UIImageView alloc] init];
    m_ImageViewFull.frame = m_ViewPicture.frame;
    m_ImageViewFull.layer.borderWidth = 1;
    [self.view addSubview:m_ImageViewFull];
    
    
    //View buttons
    frm = m_ImageViewFull.frame;
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.size.height = 40;
    }
    else if(IS_IPAD)
    {
        frm.size.height = 60;
    }
    else
    {
        frm.size.height = 50;
    }
    
   // frm.origin.y = m_ImageViewFull.frame.origin.y + m_ImageViewFull.frame.size.height + 1.0/2 * ();
    
    if (IS_IPHONE_4_OR_LESS)
    {
        frm.origin.y = m_ImageViewFull.frame.origin.y + m_ImageViewFull.frame.size.height + 10;
    }
    else if(IS_IPAD)
    {
        frm.origin.y = m_ImageViewFull.frame.origin.y + m_ImageViewFull.frame.size.height + 20;
    }
    else if(IS_IPHONE_5)
    {
       frm.origin.y = m_ImageViewFull.frame.origin.y + m_ImageViewFull.frame.size.height + 30;
    }
    else
    {
        frm.origin.y = m_ImageViewFull.frame.origin.y + m_ImageViewFull.frame.size.height + 40;
    }
    
    m_ViewButton.frame = frm;
    [m_ViewButton setBackgroundColor:[UIColor clearColor]];
    
    //bonus
    frm.size.width = m_ViewButton.frame.size.height;
    frm.size.height = frm.size.width;
    frm.origin.x = 0;
    frm.origin.y = 0;
    m_BtnCamera.frame = frm;
    
    CGFloat l_delta = 1.0/3 *(m_ViewButton.frame.size.width - 4 * m_BtnCamera.frame.size.width);
    //share
    frm = m_BtnCamera.frame;
    frm.origin.x = m_BtnCamera.frame.origin.x + m_BtnCamera.frame.size.width + l_delta;
    m_BtnShare.frame = frm;
    
    //replay
    frm = m_BtnShare.frame;
    frm.origin.x = m_BtnShare.frame.origin.x + m_BtnShare.frame.size.width + l_delta;
    m_BtnReplay.frame = frm;
    
    //next
    frm = m_BtnShare.frame;
    frm.origin.x = m_BtnReplay.frame.origin.x + m_BtnReplay.frame.size.width + l_delta;
    m_BtnNext.frame = frm;
}


- (void)InitArrayUIImageView
{
    NSInteger l_size = NUMBER_V_ITEM * NUMBER_H_ITEM;
    CGFloat imgViewWidth = m_ViewPicture.frame.size.width / NUMBER_H_ITEM;
    CGFloat imgViewHeight = m_ViewPicture.frame.size.height / NUMBER_V_ITEM;
    
    m_ArrayUIImageView = [[NSMutableArray alloc] init];
    for (int i = 0; i < l_size; i++)
    {
        UIImageView *l_ImgView = [[UIImageView alloc] init];
        CGRect frmImgView;
        frmImgView.size.width = imgViewWidth;
        frmImgView.size.height = imgViewHeight;
        l_ImgView.frame = frmImgView;
        l_ImgView.layer.borderWidth = 5;
        
        l_ImgView.userInteractionEnabled = YES;
        l_ImgView.multipleTouchEnabled = FALSE;
        UIPanGestureRecognizer *l_Pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(HandlePan:)];
        [l_ImgView addGestureRecognizer:l_Pan];
        
        [m_ArrayUIImageView addObject:l_ImgView];
        [m_ViewPicture addSubview:l_ImgView];
    }
}

- (void)ResetTimer: (NSInteger) p_time
{
    m_CurrentTime = p_time;
    m_LblTime.text = [NSString stringWithFormat:@"%i", m_CurrentTime];
    m_Timer = [NSTimer scheduledTimerWithTimeInterval:1
                                               target:self
                                             selector:@selector(TimeOut:)
                                             userInfo:nil
                                              repeats:YES];
}

- (void)TimoutAnimation: (NSTimer*)p_timer
{
    [p_timer invalidate];
    p_timer = NULL;
    
    for (UIImageView* l_ImgView in m_ArrayUIImageView)
    {
        l_ImgView.userInteractionEnabled = YES;
    }
    
    m_isAnimation = FALSE;
    m_DragObject = NULL;
    m_DestinationObject = NULL;
}

- (void)TimeOut: (NSTimer*)p_timer
{
    m_CurrentTime += 1;
    m_LblTime.text = [NSString stringWithFormat:@"%li", (long)m_CurrentTime];
    
}

- (BOOL) IsFinished
{
    for (int i = 0; i < m_ArrayUIImageView.count; i++)
    {
        //NSLog(@"i = %i and uiiamgeview: %li", i, (long)[m_ArrayUIImageView[i] tag]);
        if ([m_ArrayUIImageView[i] tag] != i)
        {
            return FALSE;
        }
    }
    
    return TRUE;
}


- (void)GameOver
{
    [[SoundController GetSingleton] PlaySoundCongratulation];
    if (m_Timer)
    {
        [m_Timer invalidate];
    }
    m_State = GAMEOVER;
    [[Configuration GetSingleton] WriteScore:m_CurrentTime];
    m_LblBestTime.text = [NSString stringWithFormat:@"%li", (long)[[Configuration GetSingleton] GetScore]];
    
    if (m_TypeTakePhoto && m_ImageTake)
    {
        [self ShowFullPicture: m_ImageTake];
    }
    else
    {
        [self ShowFullPicture:[self GetPicutre:[[Configuration GetSingleton] GetLevel]]];
    }
}


- (void)ShowFullPicture:(UIImage*) p_image
{
    [m_ImageViewFull setImage: p_image];
    m_ImageViewFull.hidden = FALSE;
    m_ViewPicture.hidden = TRUE;
    m_BtnNext.enabled = TRUE;
    
}

- (void)ShowRandomPicture : (UIImage*) p_image
{
    NSInteger l_size = NUMBER_V_ITEM * NUMBER_H_ITEM;
    CGFloat imgWidth = p_image.size.width/NUMBER_H_ITEM;
    CGFloat imgheight = p_image.size.height/NUMBER_V_ITEM;
    
    for (int i= 0; i < l_size; i++)
    {
        UIImageView *l_imageView = m_ArrayUIImageView[i];
        
        if (l_imageView == nil || l_imageView == NULL) {
            l_imageView = [[UIImageView alloc] init];
        }
        CGRect frm = CGRectMake((i % NUMBER_H_ITEM) * imgWidth, (i / NUMBER_V_ITEM) * imgheight, imgWidth, imgheight);
        CGImageRef imgRef = CGImageCreateWithImageInRect(p_image.CGImage, frm);
        UIImage *img = [UIImage imageWithCGImage:imgRef];
        
        [l_imageView setImage:img];
        [l_imageView setTag:i];
        [l_imageView.layer setBorderColor:[UIColor blackColor].CGColor];
        l_imageView.layer.borderWidth = 1;
        
    }
    
    [self RandomArray:m_ArrayUIImageView];
    
    m_ImageViewFull.hidden = TRUE;
    m_ViewPicture.hidden = FALSE;
    m_BtnNext.enabled = FALSE;
    
    //[m_LblTime setTextColor:[UIColor redColor]];
    [m_LblTime setText:[NSString stringWithFormat:@"%i",TIMEOUT]];
    NSString *l_level_string = [NSString stringWithFormat:@"LEVEL: %li", (long)[[Configuration GetSingleton] GetLevel]];
    m_LblLevel.text = l_level_string;
    
}

- (void)RandomArray : (NSMutableArray*) p_array
{
    for (NSUInteger i = p_array.count-1; i > 0; i--)
    {
        NSUInteger l_temp = arc4random_uniform((int)i+1);
        [p_array exchangeObjectAtIndex:i withObjectAtIndex:l_temp];
        
    }
    
    for (NSInteger i = 0; i < m_ArrayUIImageView.count; i++)
    {
        UIImageView *MyImgView = m_ArrayUIImageView[i];
        CGRect frm = MyImgView.frame;
        CGFloat x = (i % (NSInteger)NUMBER_H_ITEM) * frm.size.width;
        CGFloat y = (i / (NSInteger)NUMBER_V_ITEM) * frm.size.height;
        frm.origin.x = x;
        frm.origin.y = y;
        MyImgView.frame = frm;
        [MyImgView.layer setBorderColor:[UIColor blackColor].CGColor];
        MyImgView.hidden = FALSE;
    }
}





- (UIImage*)GetPicutre : (NSInteger) p_level
{
    NSString *l_nameImage = [NSString stringWithFormat:@"%li.jpg", (long)p_level];
    UIImage *l_img = [UIImage imageNamed:l_nameImage];
    NSLog(@"iamge: %@", l_nameImage);
    return l_img;
}

- (void)ExchangeFromTag: (NSInteger)p_from ToTag:(NSInteger)p_to
{
    NSInteger i = 0;
    for (UIImageView *MyImageView in m_ArrayUIImageView)
    {
        if (MyImageView.tag == p_from)
        {
            break;
        }
        
        i++;
    }
    
    
    NSInteger j = 0;
    for (UIImageView *MyImageView in m_ArrayUIImageView)
    {
        if (MyImageView.tag == p_to)
        {
            break;
        }
        
        j++;
    }
    
    
    [m_ArrayUIImageView exchangeObjectAtIndex:i withObjectAtIndex:j];
    
}

- (void)HandlePan: (UIPanGestureRecognizer*)sender
{
    [m_lockMain tryLock];
    switch (sender.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            //NSLog(@"UIGestureRecognizerStateBegan");
            if(m_DragObject != NULL || m_isAnimation == TRUE)
            {
                break;
            }
            else
            {
                //NSLog(@"dragObject is  NULL");
                if ([sender numberOfTouches] == 1)
                {
                    // one finger
                    CGPoint touchPoint = [sender locationInView:self.view];
                    
                    m_DragObject = sender.view;
                    self.touchOffset = CGPointMake(touchPoint.x - sender.view.frame.origin.x,
                                                   touchPoint.y - sender.view.frame.origin.y);
                    self.homePosition = CGPointMake(sender.view.frame.origin.x,
                                                    sender.view.frame.origin.y);
                    
                    [m_ViewPicture bringSubviewToFront:m_DragObject];
                    
                    
                    for (UIImageView* l_ImgView in m_ArrayUIImageView)
                    {
                        if (l_ImgView.tag != m_DragObject.tag)
                        {
                            l_ImgView.userInteractionEnabled = NO;
                        }
                    }
                }
            }
            
            break;
        }
            
            
        case UIGestureRecognizerStateChanged:
        {
            if(m_DragObject == NULL || m_isAnimation == TRUE)
            {
                break;
            }
            
            CGPoint  touchPoint = [sender locationInView:self.view];
            CGRect newDragObjectFrame = CGRectMake(touchPoint.x - touchOffset.x,
                                                   touchPoint.y - touchOffset.y,
                                                   m_DragObject.frame.size.width,
                                                   m_DragObject.frame.size.height);
            
            m_DragObject.frame = newDragObjectFrame;
            
            CGFloat l_area = 0;
            for(UIImageView *l_tempIcon in m_ArrayUIImageView)
            {
                if (l_tempIcon.tag == m_DragObject.tag)
                {
                    
                }
                else
                {
                    
                    CGRect frm1 = m_DragObject.frame;
                    CGRect frm2 = l_tempIcon.frame;
                    
                    CGRect frmIntersection = CGRectIntersection(frm1, frm2);
                    CGFloat l_tempArea = CGRectGetWidth(frmIntersection) * CGRectGetHeight(frmIntersection);
                    if (l_tempArea > l_area)
                    {
                        l_area = l_tempArea;
                        m_DestinationObject = l_tempIcon;
                        
                    }
                }
            }
            
            for(UIImageView *l_tempIcon in m_ArrayUIImageView)
            {
                [l_tempIcon.layer setBorderColor:[UIColor blackColor].CGColor];
            }
            
            [m_DragObject.layer setBorderColor:[UIColor blueColor].CGColor];
            [m_DestinationObject.layer setBorderColor:[UIColor blueColor].CGColor];
            
            break;
        }
            
            
        case UIGestureRecognizerStateEnded:
        {
            if (m_isAnimation == TRUE || m_DragObject == NULL)
            {
                break;
            }
          
            if (m_DestinationObject != nil && m_DestinationObject != NULL)
            {
                m_isAnimation = TRUE;
                
                //change position in array
                [self ExchangeFromTag:m_DragObject.tag ToTag:m_DestinationObject.tag];
                //change position in gui
                [m_ViewPicture bringSubviewToFront:m_DestinationObject];
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                CGRect frm1 = m_DestinationObject.frame;
                m_DestinationObject.frame = CGRectMake(self.homePosition.x, self.homePosition.y,
                                              m_DragObject.frame.size.width,
                                              m_DragObject.frame.size.height);
                m_DragObject.frame = frm1;
                [UIView commitAnimations];
                
            
                [[SoundController GetSingleton] PlaySoundCorrect];
                if (m_State == PREPAREPLAY || m_State == GAMEOVER)
                {
                    m_State = PLAYING;
                    [self ResetTimer:TIMEOUT];
                }
                
                if([self IsFinished])
                {
                    [self GameOver];
                }
                
                [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(TimoutAnimation:) userInfo:m_DragObject repeats:NO];
    
            }
            else
            {
                m_DragObject.frame = CGRectMake(self.homePosition.x, self.homePosition.y,
                                                   m_DragObject.frame.size.width,
                                                   m_DragObject.frame.size.height);
                
                [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(TimoutAnimation:) userInfo:m_DragObject repeats:NO];
            }
            
            break;
        }
            
            
        case UIGestureRecognizerStatePossible:
        {
            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        }
            
        default:
        {
            NSLog(@"default");
            break;
        }
    }//end switch(sender.state)
    
    [m_lockMain unlock];
}//end HandlePan


- (void) ShowSpeaker
{
    if ([[SoundController GetSingleton] GetMute])
    {
        NSLog(@"Mute");
        [m_BtnSpeaker setImage:[UIImage imageNamed:@"btn_mute.png"] forState: UIControlStateNormal];
    }
    else
    {
        NSLog(@"UnMute");
        [m_BtnSpeaker setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SpeakerClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [self ShowSpeaker];
}

- (IBAction)ReplayPicture:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];

    [m_Timer invalidate];
    m_State = PREPAREPLAY;
    m_LblTime.text = [NSString stringWithFormat:@"%li", (long)TIMEOUT];
    m_BtnShare.enabled = TRUE;
    
    if (m_TypeTakePhoto)
    {
        [self ShowRandomPicture:m_ImageTake];
        m_BtnNext.enabled = TRUE;
    }else
    {
        [self ShowRandomPicture:[self GetPicutre:[[Configuration GetSingleton] GetLevel]]];
    }
}

//Next level
- (IBAction)NextPicture:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    if (m_TypeTakePhoto)
    {
        m_TypeTakePhoto = FALSE;
        m_ImageTake = nil;
    }
    else
    {
        NSInteger l_level = [[Configuration GetSingleton] GetLevel];
        l_level += 1;
        [[Configuration GetSingleton] WriteLevel:l_level];
    }
    
    m_State = PREPAREPLAY;
    [self ShowRandomPicture:[self GetPicutre:[[Configuration GetSingleton] GetLevel]]];
    
    [[GADMasterViewController GetSingleton] ResetAdInterstitialView:self];

}


//bonus click
- (IBAction)BonusClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [self TakePhoto];

}


//share social
- (IBAction) ShareClick: (id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    NSString * message = @"#Match Picture Puzzle";
    UIImage * image = [[Configuration GetSingleton] TakeScreenshot];
    
    NSArray * shareItems = @[message, image];
    UIActivityViewController * ActivityVC = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:ActivityVC animated:YES completion:nil];
    
}


//Picker
- (void)TakePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else
    {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}


#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Choose image done !!!");
    m_ImageTake = info[UIImagePickerControllerEditedImage];
    if (m_ImageTake)
    {
        m_TypeTakePhoto = TRUE;
        [self ShowRandomPicture:m_ImageTake];
        m_BtnNext.enabled = TRUE;
    }
    

    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //m_TypeTakePhoto = FALSE;
    //m_ImageTake = nil;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
