//
//  PlayViewController.m
//  DoDanGian
//
//  Created by Binh Du  on 4/22/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *LblScore;

@end

@implementation PlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"btn_fb.png"];
    CGSize imgSize = _LblScore.frame.size;
    
    UIGraphicsBeginImageContext( imgSize );
    [img drawInRect:CGRectMake(0,0,imgSize.width,imgSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _LblScore.backgroundColor = [UIColor colorWithPatternImage:newImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
