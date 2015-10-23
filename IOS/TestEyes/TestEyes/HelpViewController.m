//
//  HelpViewController.m
//  Super Eyes
//
//  Created by Nguyễn Thế Bình on 8/15/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//

#import "HelpViewController.h"
#import "Define.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main.png"]]];
    
    CGFloat l_spaceleft = 10.0;
    CGFloat l_spacevertical = 20;
    CGFloat l_spacehorizon = 30;
    if(IS_IPHONE_4_OR_LESS)
    {
        l_spacevertical = 0;
    }
    
    UILabel *LblHeader = [[UILabel alloc] init];
    
    CGRect frm;
    frm.size.width = SCREEN_WIDTH - 2 * l_spaceleft;
    frm.size.height = 50;
    frm.origin.x = l_spaceleft;
    frm.origin.y = 15;
    LblHeader.frame = frm;
    
    [LblHeader setTextColor:[UIColor blueColor]];
    [LblHeader setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    if (IS_IPAD) {
        [LblHeader setFont:[UIFont systemFontOfSize:25 weight:0.5]];
    }
    [LblHeader setTextAlignment:NSTextAlignmentLeft];
    //LblHeader.lineBreakMode = UILineBreakModeWordWrap;
    LblHeader.numberOfLines = 2;
    [LblHeader setText:@"LEVELS - WHAT ANIMAL'S EYESIGHT DO YOU HAVE?"];
    
    [self.view addSubview:LblHeader];
    
    
    ///
    ////////////////////////////////////////Line 1
    //
    
    CGFloat l_WIDTH = 1.0/4 * (SCREEN_WIDTH - 2 * l_spaceleft - 3*l_spacehorizon);
    
    UIView *ViewLine1 = [[UIView alloc] init];
    frm.size.width = SCREEN_WIDTH - 2 *l_spaceleft;
    frm.size.height = l_WIDTH + 1.0/2 * l_WIDTH;
    frm.origin.x = l_spaceleft;
    frm.origin.y = LblHeader.frame.origin.y + LblHeader.frame.size.height + l_spacevertical;
    ViewLine1.frame = frm;
    [self.view addSubview:ViewLine1];
    //BAT
    frm.size.width = l_WIDTH;
    frm.size.height = frm.size.width;
    frm.origin.x = 0;
    frm.origin.y = 0;
    UIImageView *ImageBat = [[UIImageView alloc] initWithFrame:frm];
    [ImageBat setImage:[UIImage imageNamed:@"bat.png"]];
    [ViewLine1 addSubview:ImageBat];
    
    frm = ImageBat.frame;
    frm.size.height *= 0.5;
    frm.origin.y = ImageBat.frame.origin.y + ImageBat.frame.size.height;
    UILabel *LblBat = [[UILabel alloc] initWithFrame:frm];
    [LblBat setTextColor:[UIColor redColor]];
    [LblBat setFont:[UIFont systemFontOfSize:8 weight:0.1]];
    if (IS_IPAD) {
        [LblBat setFont:[UIFont systemFontOfSize:13 weight:0.2]];
    }
    
    [LblBat setTextAlignment:NSTextAlignmentCenter];
    [LblBat setText:@"Bat: 0-4"];
    [ViewLine1 addSubview:LblBat];
    
    //MOLE
    l_spaceleft *=3;

    frm = ImageBat.frame;
    frm.origin.x = ImageBat.frame.origin.x + ImageBat.frame.size.width + l_spacehorizon;
    UIImageView *ImageMole = [[UIImageView alloc] initWithFrame:frm];
    [ImageMole setImage:[UIImage imageNamed:@"mole.png"]];
    [ViewLine1 addSubview:ImageMole];
    
    frm = LblBat.frame;
    frm.origin.x = LblBat.frame.origin.x + LblBat.frame.size.width + l_spacehorizon;
    UILabel *LblMole = [[UILabel alloc] initWithFrame:frm];
    [LblMole setTextColor:[LblBat textColor]];
    [LblMole setFont:[LblBat font]];
    [LblMole setTextAlignment:[LblBat textAlignment]];
    [LblMole setText:@"Mole: 5-9"];
    [ViewLine1 addSubview:LblMole];

    //DOG
    frm = ImageMole.frame;
    frm.origin.x = ImageMole.frame.origin.x + ImageMole.frame.size.width + l_spacehorizon;
    UIImageView *ImageDog = [[UIImageView alloc] initWithFrame:frm];
    [ImageDog setImage:[UIImage imageNamed:@"dog.png"]];
    [ViewLine1 addSubview:ImageDog];
    
    frm = LblMole.frame;
    frm.origin.x = LblMole.frame.origin.x + LblMole.frame.size.width+ l_spacehorizon;
    UILabel *LblDog = [[UILabel alloc] initWithFrame:frm];
    [LblDog setTextColor:[LblMole textColor]];
    [LblDog setFont:[LblMole font]];
    [LblDog setTextAlignment:[LblMole textAlignment]];
    [LblDog setText:@"Dog: 10-14"];
    [ViewLine1 addSubview:LblDog];
    
    //CAT
    frm = ImageDog.frame;
    frm.origin.x = ImageDog.frame.origin.x + ImageDog.frame.size.width + l_spacehorizon;
    UIImageView *ImageCat = [[UIImageView alloc] initWithFrame:frm];
    [ImageCat setImage:[UIImage imageNamed:@"cat.png"]];
    [ViewLine1 addSubview:ImageCat];
    
    frm = LblDog.frame;
    frm.origin.x = LblDog.frame.origin.x + LblDog.frame.size.width+ l_spacehorizon;
    UILabel *LblCat = [[UILabel alloc] initWithFrame:frm];
    [LblCat setTextColor:[LblDog textColor]];
    [LblCat setFont:[LblDog font]];
    [LblCat setTextAlignment:[LblDog textAlignment]];
    [LblCat setText:@"Cat: 15-19"];
    [ViewLine1 addSubview:LblCat];
    
    //[ViewLine1 setBackgroundColor:[UIColor blackColor]];
    
    ///
    ////////////////////////////////////////Line 2
    //
    
    UIView *ViewLine2 = [[UIView alloc] init];
    frm = ViewLine1.frame;
    frm.origin.y = ViewLine1.frame.origin.y + ViewLine1.frame.size.height;
    ViewLine2.frame = frm;
    [self.view addSubview:ViewLine2];
    //TIGER
    frm = ImageBat.frame;
    frm.origin.y = 0;
    UIImageView *ImageTiger = [[UIImageView alloc] initWithFrame:frm];
    [ImageTiger setImage:[UIImage imageNamed:@"tiger.png"]];
    [ViewLine2 addSubview:ImageTiger];
    
    frm = ImageTiger.frame;
    frm.size.height *= 0.5;
    frm.origin.y = ImageTiger.frame.origin.y + ImageTiger.frame.size.height;
    UILabel *LblTiger = [[UILabel alloc] initWithFrame:frm];
    [LblTiger setTextColor:[UIColor redColor]];
    [LblTiger setFont:[UIFont systemFontOfSize:8 weight:0.1]];
    if (IS_IPAD) {
        [LblTiger setFont:[UIFont systemFontOfSize:13 weight:0.2]];
    }
    [LblTiger setTextAlignment:NSTextAlignmentCenter];
    [LblTiger setText:@"Tiger: 20-24"];
    [ViewLine2 addSubview:LblTiger];
    
    //[ViewLine2 setBackgroundColor:[UIColor blackColor]];
    //HAWK
    frm = ImageTiger.frame;
    frm.origin.x = ImageTiger.frame.origin.x + ImageTiger.frame.size.width+ l_spacehorizon;
    UIImageView *ImageHawk = [[UIImageView alloc] initWithFrame:frm];
    [ImageHawk setImage:[UIImage imageNamed:@"hawk.png"]];
    [ViewLine2 addSubview:ImageHawk];
    
    frm = LblTiger.frame;
    frm.origin.x = LblTiger.frame.origin.x + LblTiger.frame.size.width+ l_spacehorizon;
    UILabel *LblHawk = [[UILabel alloc] initWithFrame:frm];
    [LblHawk setTextColor:[LblTiger textColor]];
    [LblHawk setFont:[LblTiger font]];
    [LblHawk setTextAlignment:[LblTiger textAlignment]];
    [LblHawk setText:@"Hawk: 25-29"];
    [ViewLine2 addSubview:LblHawk];
    
    //ROBOT
    frm = ImageHawk.frame;
    frm.origin.x = ImageHawk.frame.origin.x + ImageHawk.frame.size.width+ l_spacehorizon;
    UIImageView *ImageRobot = [[UIImageView alloc] initWithFrame:frm];
    [ImageRobot setImage:[UIImage imageNamed:@"robot.png"]];
    [ViewLine2 addSubview:ImageRobot];
    
    frm = LblHawk.frame;
    frm.origin.x = LblHawk.frame.origin.x + LblHawk.frame.size.width+ l_spacehorizon;
    UILabel *LblRobot = [[UILabel alloc] initWithFrame:frm];
    [LblRobot setTextColor:[LblHawk textColor]];
    [LblRobot setFont:[LblHawk font]];
    [LblRobot setTextAlignment:[LblHawk textAlignment]];
    [LblRobot setText:@"Robot:30-34"];
    [ViewLine2 addSubview:LblRobot];
    
    //SUPERMAN
    frm = ImageRobot.frame;
    frm.origin.x = ImageRobot.frame.origin.x + ImageRobot.frame.size.width+ l_spacehorizon;
    UIImageView *ImageSuperman = [[UIImageView alloc] initWithFrame:frm];
    [ImageSuperman setImage:[UIImage imageNamed:@"superman.png"]];
    [ViewLine2 addSubview:ImageSuperman];
    
    frm = LblRobot.frame;
    frm.origin.x = LblRobot.frame.origin.x + LblRobot.frame.size.width+ l_spacehorizon;
    UILabel *LblSuperman = [[UILabel alloc] initWithFrame:frm];
    [LblSuperman setTextColor:[LblRobot textColor]];
    [LblSuperman setFont:[LblRobot font]];
    [LblSuperman setTextAlignment:[LblRobot textAlignment]];
    [LblSuperman setText:@"Superman: 35"];
    [ViewLine2 addSubview:LblSuperman];
    
    
    //
    /////////////////// TEST YOUR COLOR VISION
    //
    frm.size.width = ViewLine1.frame.size.width;
    frm.size.height = SCREEN_HEIGHT - ViewLine2.frame.origin.y - ViewLine2.frame.size.height + l_spacevertical;
    frm.origin.x = ViewLine1.frame.origin.x;
    frm.origin.y = ViewLine2.frame.origin.y + ViewLine2.frame.size.height;
    UIView *ViewGuide = [[UIView alloc] initWithFrame:frm];
    [self.view addSubview:ViewGuide];
    
    //LblTitle
    frm.size.width = ViewGuide.frame.size.width;
    frm.size.height = 40;
    frm.origin.x = 0;
    frm.origin.y = 0;
    UILabel *LblTitle = [[UILabel alloc] initWithFrame:frm];
    [LblTitle setTextColor:[UIColor blackColor]];
    [LblTitle setFont:[UIFont systemFontOfSize:20 weight:0.5]];
    if (IS_IPAD) {
        [LblTitle setFont:[UIFont systemFontOfSize:25 weight:0.5]];
    }
    [LblTitle setTextAlignment:NSTextAlignmentCenter];
    LblTitle.numberOfLines = 1;
    [LblTitle setText:@"TEST YOUR COLOR VISION"];
    
    [ViewGuide addSubview:LblTitle];
    
    CGFloat l_fontguide = 0;
    if (IS_IPHONE_4_OR_LESS) {
        l_fontguide = 13;
    }
    else if(IS_IPAD)
    {
        l_fontguide = 20;
    }
    else
        l_fontguide = 15;
    //LblLine1
    frm = LblTitle.frame;
    frm.origin.y = LblTitle.frame.origin.y + LblTitle.frame.size.height;
    UILabel *LblLine1 = [[UILabel alloc] initWithFrame:frm];
    [LblLine1 setTextColor:[UIColor darkGrayColor]];
    [LblLine1 setFont:[UIFont systemFontOfSize:l_fontguide weight:0.2]];
    [LblLine1 setTextAlignment:NSTextAlignmentLeft];
    LblLine1.numberOfLines = 2;
    [LblLine1 setText:@"1. Click on the box that has an irregular color compared to the rest of the boxes."];
    [ViewGuide addSubview:LblLine1];
    
    //LblLine2
    frm = LblTitle.frame;
    frm.origin.y = LblLine1.frame.origin.y + LblLine1.frame.size.height;
    UILabel *LblLine2 = [[UILabel alloc] initWithFrame:frm];
    [LblLine2 setTextColor:[UIColor darkGrayColor]];
    [LblLine2 setFont:[UIFont systemFontOfSize:l_fontguide weight:0.2]];
    [LblLine2 setTextAlignment:NSTextAlignmentLeft];
    LblLine2.numberOfLines = 2;
    [LblLine2 setText:@"2. The test starts when you click on the first box."];
    [ViewGuide addSubview:LblLine2];
    
    //LblLine3
    frm = LblTitle.frame;
    frm.origin.y = LblLine2.frame.origin.y + LblLine2.frame.size.height;
    UILabel *LblLine3 = [[UILabel alloc] initWithFrame:frm];
    [LblLine3 setTextColor:[UIColor darkGrayColor]];
    [LblLine3 setFont:[UIFont systemFontOfSize:l_fontguide weight:0.2]];
    [LblLine3 setTextAlignment:NSTextAlignmentLeft];
    LblLine3.numberOfLines = 2;
    [LblLine3 setText:@"3. You have 15 seconds to decide on each grid."];
    [ViewGuide addSubview:LblLine3];
    
    //LblLine4
    frm = LblTitle.frame;
    frm.origin.y = LblLine3.frame.origin.y + LblLine3.frame.size.height;
    UILabel *LblLine4 = [[UILabel alloc] initWithFrame:frm];
    [LblLine4 setTextColor:[UIColor darkGrayColor]];
    [LblLine4 setFont:[UIFont systemFontOfSize:l_fontguide weight:0.2]];
    [LblLine4 setTextAlignment:NSTextAlignmentLeft];
    LblLine4.numberOfLines = 2;
    [LblLine4 setText:@"4. When you click the wrong box you will lose 3 seconds."];
    [ViewGuide addSubview:LblLine4];
    
    
    //BtnBack
    frm.size.width = 2.0/3 * LblLine4.frame.size.width;
    frm.size.height = 1.0/5 * frm.size.width;
    frm.origin.x = 1.0/2 * (LblLine4.frame.size.width - frm.size.width);
    frm.origin.y = LblLine4.frame.origin.y + LblLine4.frame.size.height + l_spacevertical;
    UIButton *BtnBack = [[UIButton alloc] initWithFrame:frm];
    [BtnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat l_fontbutton = 20;
    CGFloat l_fontsize = 15;
    CGFloat l_fontweight = 0.2;
    if (IS_IPHONE_4_OR_LESS)
    {
        l_fontsize = 13;
        l_fontbutton = 18;
    }
    if (IS_IPAD)
    {
        l_fontsize = 18;
        l_fontbutton = 25;
    }
    [BtnBack.titleLabel setFont:[UIFont systemFontOfSize:l_fontbutton weight:l_fontweight]];
    [BtnBack setTitle:@"BACK" forState:UIControlStateNormal];
    BtnBack.layer.cornerRadius = 0.1 * frm.size.height;
    [BtnBack setBackgroundColor:[UIColor colorWithRed:76/255.0 green:157/255.0 blue:231/255.0 alpha:1]];
    [ViewGuide addSubview:BtnBack];
    [BtnBack addTarget:self action:@selector(BackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //uiview footer
    if (!IS_IPHONE_4_OR_LESS)
    {
        frm.size.width = SCREEN_WIDTH;
        frm.size.height = 50;
        if(SCREEN_HEIGHT <= 400)
        {
            frm.size.height = 32;
        }
        else if(SCREEN_HEIGHT > 400 && SCREEN_HEIGHT <= 720)
        {
            frm.size.height = 50;
        }else if(SCREEN_HEIGHT > 720)
        {
            frm.size.height = 90;
        }

        frm.origin.x = 0;
        frm.origin.y = SCREEN_HEIGHT - frm.size.height;
        UIView *ViewFooter = [[UIView alloc] initWithFrame:frm];
        [self.view addSubview:ViewFooter];
        
        frm = ViewFooter.frame;
        frm.origin.x = 0;
        frm.origin.y =  0;
        UILabel *m_UIlabelCopyright = [[UILabel alloc] initWithFrame:frm];
        [m_UIlabelCopyright setTextColor:[UIColor darkGrayColor]];
        [m_UIlabelCopyright setText:TEXT_COPYRIGHT];
        [m_UIlabelCopyright setTextAlignment:NSTextAlignmentCenter];
        if (IS_IPHONE_4_OR_LESS)
        {
            [m_UIlabelCopyright setFont:[UIFont systemFontOfSize:10 weight:0.5]];
        }
        else if (IS_IPAD)
        {
            [m_UIlabelCopyright setFont:[UIFont systemFontOfSize:20 weight:0.5]];
        }
        else
        {
            [m_UIlabelCopyright setFont:[UIFont systemFontOfSize:15 weight:0.5]];
        }
        
        [ViewFooter addSubview:m_UIlabelCopyright];
        
        [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:ViewFooter.frame];
    }
    
}

- (void)BackClick: (UIButton*)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [self performSegueWithIdentifier:@"segue2Play" sender:self];
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
