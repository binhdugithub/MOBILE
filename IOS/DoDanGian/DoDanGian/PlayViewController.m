//
//  PlayViewController.m
//  DoDanGian
//
//  Created by Binh Du  on 4/22/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import "PlayViewController.h"
#import "Define.h"

@interface PlayViewController ()
@property (weak, nonatomic) IBOutlet UIView *VHeader;
@property (weak, nonatomic) IBOutlet UIButton *BtnBack;
@property (weak, nonatomic) IBOutlet UIButton *BtnLevel;
@property (weak, nonatomic) IBOutlet UIButton *BtnCoint;

@property (weak, nonatomic) IBOutlet UIView *VQuestion;
@property (weak, nonatomic) IBOutlet UITextView *TVQuestion;
@property (weak, nonatomic) IBOutlet UIImageView *IVThinking;

@property (weak, nonatomic) IBOutlet UIView *VAnswer;
//@property (weak, nonatomic) IBOutlet UIView *V3Line;
@property (weak, nonatomic) IBOutlet UIButton *BtnSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *BtnClear;
@property (weak, nonatomic) IBOutlet UIButton *BtnShare;
@property (weak, nonatomic) IBOutlet UIButton *BtnAsk;


@property (weak, nonatomic) IBOutlet UIView *VSuggestion;

@property (weak, nonatomic) IBOutlet UIView *VFooter;
@property (weak, nonatomic) IBOutlet UILabel *LblCopyright;

@end

@implementation PlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CalculateView];
   
   /* UIImage *img = [UIImage imageNamed:@"btn_fb.png"];
    CGSize imgSize = _LblScore.frame.size;
    
    UIGraphicsBeginImageContext( imgSize );
    [img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _LblScore.backgroundColor = [UIColor colorWithPatternImage:newImage];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)CalculateView
{
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    //1. background
    //[self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    //2 100number
    
    //3 Footer
    CGRect frm = _VFooter.frame;
    frm.size.width = W;
    frm.size.height = H_FOOTER * H;
    frm.origin.x = 0;
    frm.origin.y = H - frm.size.height;
    _VFooter.frame = frm;
    
    //Copyrith
    frm.size.height =  H_FOOTER * H * 1.0/2;
    frm.origin.x = 0;
    frm.origin.y =  H_FOOTER * H * 1.0/2;
    _LblCopyright.frame = frm;
    
    //3 _VSuggestion
    CGFloat BTN_W = W * 4.0/41;
    frm.size.width = BTN_W;
    frm.size.height = BTN_W;
    for (NSUInteger i = 0; i < 18; i++)
    {
        UIButton *MyButton = [[UIButton alloc] init];
        frm.origin.x = ((i%9) + 1) * 1.0/8 * frm.size.width + (i%9) * frm.size.width;
        frm.origin.y = 1.0/8 * frm.size.height + (i / 9) * ( frm.size.height + 1.0/8 * frm.size.height);
        MyButton.frame = frm;
        MyButton.layer.cornerRadius = 5;
        MyButton.backgroundColor = [UIColor darkGrayColor];
        
        [_VSuggestion addSubview:MyButton];
    }
    
    
    frm = _VFooter.frame;
    frm.size.width = W;
    frm.size.height = 2 * BTN_W + 3.0/8 * BTN_W;
    frm.origin.x = 0;
    frm.origin.y = H - _VFooter.frame.size.height - frm.size.height;
    _VSuggestion.frame = frm;
    
    //4 _VAnswer
    BTN_W = W * 1.0 / ( 10 + 11.0/8);
    frm.size.width = W;
    frm.size.height = (3 + 4 * 1.0/8) * BTN_W;
    frm.origin.x = 0;
    frm.origin.y = _VSuggestion.frame.origin.y - frm.size.height - BTN_W;
    
    if (H > 480)
    {
        frm.origin.y = _VSuggestion.frame.origin.y - frm.size.height - 2 * BTN_W;
    }
    
    _VAnswer.frame = frm;
    
    //Speaker
    frm = _BtnSpeaker.frame;
    frm.size.width = W_ICON_IP4 * W;
    frm.size.height = frm.size.width;
    frm.origin.x = 1.0/4 * frm.size.width;
    
    CGFloat sk_y = (_VAnswer.frame.size.height - 2 * frm.size.height) * 1.0/3;
    frm.origin.y = sk_y;
    _BtnSpeaker.frame = frm;
    
    //Clear
    frm = _BtnSpeaker.frame;
    frm.origin.y = sk_y * 2 + frm.size.height;
    _BtnClear.frame = frm;
    
    //facebook
    frm = _BtnSpeaker.frame;
    frm.origin.x = _VAnswer.frame.size.width - 1.0/4 * frm.size.width - frm.size.width;
    _BtnShare.frame = frm;
    
    //Ask
    frm= _BtnShare.frame;
    frm.origin.y = _BtnClear.frame.origin.y;
    _BtnAsk.frame = frm;
    
    
    //5. Vquestion
    frm = _VHeader.frame;
    frm.size.width = W;
    frm.size.height = H_HEADER * H;
    frm.origin.x = 0;
    frm.origin.y = 0;
    _VHeader.frame = frm;
    
    //Back
    frm = _BtnBack.frame;
    frm.size.height = 1.0/2 * _VHeader.frame.size.height;
    frm.size.width = 3 * frm.size.height;
    frm.origin.x = _VHeader.frame.origin.x;
    frm.origin.y = 1.0/2 * (_VHeader.frame.size.height - frm.size.height);
    _BtnBack.frame = frm;
    
    //Score
    frm = _BtnBack.frame;
    frm.origin.x = _VHeader.frame.size.width - frm.size.width;
    _BtnCoint.frame = frm;
    
    //Level
    frm = _BtnLevel.frame;
    frm.size.height = _VHeader.frame.size.height - 1.0/8 * _VHeader.frame.size.height;
    frm.size.width = 3 * frm.size.height;
    frm.origin.x = 1.0/2 *( _VHeader.frame.size.width - frm.size.width);
    frm.origin.y = 1.0/2 * ( _VHeader.frame.size.height - frm.size.height);
    _BtnLevel.frame = frm;
    
    //6. Question
    frm = _VQuestion.frame;
    frm.size.width = W;
    frm.size.height = _VAnswer.frame.origin.y - _VHeader.frame.size.height - _VHeader.frame.origin.y;
    if (H > 480)
    {
        frm.size.height = _VAnswer.frame.origin.y - _VHeader.frame.size.height - _BtnSpeaker.frame.size.height - _VHeader.frame.origin.y;
    }
    frm.origin.x = 0;
    frm.origin.y = _VHeader.frame.origin.y + _VHeader.frame.size.height;
    
    _VQuestion.frame = frm;
    
    //Text Question
    frm = _VQuestion.frame;
    frm.size.width = frm.size.width - 1.0/40 * frm.size.width;
    frm.size.height = frm.size.height  - 1.0/40 * frm.size.height;
    frm.origin.x = 1.0/2 * (_VQuestion.frame.size.width - frm.size.width);
    frm.origin.y = 1.0/2 * (_VQuestion.frame.size.height - frm.size.height);
    
    _TVQuestion.frame = frm;
    _TVQuestion.layer.cornerRadius = 10;
    

    //Emotion
    frm = _BtnSpeaker.frame;
    frm.size.width *= 2;
    frm.size.height *=2;
    frm.origin.x = _VQuestion.frame.size.width - 1.0/8 * frm.size.width - frm.size.width;
    frm.origin.y = _VQuestion.frame.size.height - 1.0/8 * frm.size.height - frm.size.height;
    
    _IVThinking.frame = frm;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
