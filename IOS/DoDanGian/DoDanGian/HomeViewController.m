//
//  ViewController.m
//  DoDanGian
//
//  Created by Binh Du  on 4/20/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *IVWelcome;
@property (weak, nonatomic) IBOutlet UIButton *BtnPlay;
@property (weak, nonatomic) IBOutlet UIImageView *IVMain;
@property (weak, nonatomic) IBOutlet UIImageView *IVTitleGame;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect frm;
    frm.size.width = 1.0/3 * [UIScreen mainScreen].bounds.size.width;
    frm.size.height = 8.0/5 * frm.size.width;
    frm.origin.x = 1.0/2 * [UIScreen mainScreen].bounds.size.width;
    frm.origin.y = [UIScreen mainScreen].bounds.size.height - 1.0/3 * frm.size.height - frm.size.height;
    _IVWelcome.frame = frm;
    
    frm = _IVWelcome.frame;
    frm.size.height = 2.0/5 * frm.size.height;
    _BtnPlay.frame = frm;
    
    
    frm = [UIScreen mainScreen].bounds;
    _IVMain.frame = frm;
    
    
    frm = [UIScreen mainScreen].bounds;
    frm.size.height = 1.0/2 * frm.size.width;
    frm.origin.x = 0;
    frm.origin.y = 1.0/9 * [UIScreen mainScreen].bounds.size.height;
    _IVTitleGame.frame = frm;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
