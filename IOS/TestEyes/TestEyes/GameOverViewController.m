//
//  GameOverViewController.m
//  Super Eyes
//
//  Created by Nguyễn Thế Bình on 8/15/15.
//  Copyright (c) 2015 Nguyễn Thế Bình. All rights reserved.
//


#import "GameOverViewController.h"
#import "Define.h"

@interface GameOverViewController ()
@property (weak, nonatomic) IBOutlet UIView *ViewHeader;
@property (weak, nonatomic) IBOutlet UILabel *LblTextBestResult;
@property (weak, nonatomic) IBOutlet UILabel *LblNumberBestResult;
@property (weak, nonatomic) IBOutlet UILabel *LblTextScore;
@property (weak, nonatomic) IBOutlet UILabel *LblNumberScore;
@property (weak, nonatomic) IBOutlet GADBannerView *ViewFooter;
@property (weak, nonatomic) IBOutlet UILabel *LblNameGame;

@property (weak, nonatomic) IBOutlet UIView *ViewInfo;
@property (weak, nonatomic) IBOutlet UILabel *LblAnimal;
@property (weak, nonatomic) IBOutlet UILabel *LblDiscription;



@property (weak, nonatomic) IBOutlet UIView *ViewController;
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewAnimal;
@property (weak, nonatomic) IBOutlet UIButton *BtnShare;
@property (weak, nonatomic) IBOutlet UIButton *BtnPlayAgain;
@property (weak, nonatomic) IBOutlet UIButton *BtnInvite;

@end

@implementation GameOverViewController
@synthesize ViewHeader, LblNumberBestResult, LblNumberScore, LblTextBestResult, LblTextScore, LblNameGame;
@synthesize ViewFooter;
@synthesize ViewInfo, ImageViewAnimal, BtnPlayAgain, BtnShare, BtnInvite;
@synthesize ViewController, LblAnimal, LblDiscription;


- (void)viewDidLoad
{
    //NSLog(@"Did load");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
   // NSLog(@"Will load");
    
    [self CalculateView];
    [[GADMasterViewController GetSingleton] resetAdBannerView:self AtFrame:ViewFooter.frame];
    [[GADMasterViewController GetSingleton] ResetAdInterstitialView:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
   // NSLog(@"did disapear");
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    //NSLog(@"view will disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) CalculateView
{
    //Background
    //[self.view setBackgroundColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main.png"]]];
    
    //
    //Footer
    //
    CGRect frm;
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
    ViewFooter.frame = frm;
    [ViewFooter setBackgroundColor:[UIColor clearColor]];

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
    
    CGFloat l_space_left = 5;
    //
    // Header
    //
    frm.size.width = SCREEN_WIDTH - 2 * l_space_left;
    frm.size.height = 1.0/4 *(SCREEN_HEIGHT - ViewFooter.frame.size.height);
    frm.origin.x = 1.0/2 *(SCREEN_WIDTH - frm.size.width);
    frm.origin.y = 0;
    ViewHeader.frame = frm;
    [ViewHeader setBackgroundColor:[UIColor clearColor]];
    //[ViewHeader setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main.png"]]];
    //Name of game
    frm.size.width = ViewHeader.frame.size.width;//5.0/8 * ViewHeader.frame.size.width;
    frm.size.height = 1.0/3 * ViewHeader.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    LblNameGame.frame = frm;
    [LblNameGame setFont:[UIFont systemFontOfSize:22 weight:1]];
    if (IS_IPAD) {
        [LblNameGame setFont:[UIFont systemFontOfSize:27 weight:1]];
    }
    [LblNameGame setTextColor:[UIColor blueColor]];
    
    //LblTextBestResult
    frm.size.width = 1.0/2 * ViewHeader.frame.size.width;
    frm.size.height = 1.0/3 * ViewHeader.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 1.0/3 * ViewHeader.frame.size.height;
    LblTextBestResult.frame = frm;
    [LblTextBestResult setTextColor:[UIColor blackColor]];
    [LblTextBestResult setTextAlignment:NSTextAlignmentCenter];
    [LblTextBestResult setFont:[UIFont systemFontOfSize:13 weight:0.2]];
    if(IS_IPAD)
        [LblTextBestResult setFont:[UIFont systemFontOfSize:18 weight:0.2]];
    else if(IS_IPHONE_4_OR_LESS)
        [LblTextBestResult setFont:[UIFont systemFontOfSize:11 weight:0.2]];
    
    [LblTextBestResult setText:@"BEST RESULT"];
    
    //LblNumberBestScore
    frm = LblTextBestResult.frame;
    frm.origin.y = LblTextBestResult.frame.origin.y + LblTextBestResult.frame.size.height - 10;
    LblNumberBestResult.frame = frm;
    [LblNumberBestResult setTextColor:[UIColor redColor]];
    [LblNumberBestResult setTextAlignment:NSTextAlignmentCenter];
    [LblNumberBestResult setFont:[UIFont systemFontOfSize:30 weight:0.2]];
    if (IS_IPAD)
        [LblNumberBestResult setFont:[UIFont systemFontOfSize:35 weight:0.2]];
    else if(IS_IPHONE_4_OR_LESS)
        [LblNumberBestResult setFont:[UIFont systemFontOfSize:28 weight:0.2]];

    [LblNumberBestResult setText:[NSString stringWithFormat:@"%li", (long)[[Configuration GetSingleton] GetBestScore]]];
    
    
    //LblTextSCORE
    frm = LblTextBestResult.frame;
    frm.origin.x = LblTextBestResult.frame.origin.x + LblTextBestResult.frame.size.width;
    LblTextScore.frame = frm;
    [LblTextScore setTextColor:[UIColor blackColor]];
    [LblTextScore setTextAlignment:NSTextAlignmentCenter];
    [LblTextScore setFont:[UIFont systemFontOfSize:13 weight:0.2]];
    if(IS_IPAD)
        [LblTextScore setFont:[UIFont systemFontOfSize:18 weight:0.2]];
    else if(IS_IPHONE_4_OR_LESS)
        [LblTextScore setFont:[UIFont systemFontOfSize:11 weight:0.2]];
    
    [LblTextScore setText:@"SCORE"];
    
    //LblNumberBestScore
    frm = LblTextScore.frame;
    frm.origin.y = LblNumberBestResult.frame.origin.y;
    LblNumberScore.frame = frm;
    [LblNumberScore setTextColor:[UIColor redColor]];
    [LblNumberScore setTextAlignment:NSTextAlignmentCenter];
    [LblNumberScore setFont:[UIFont systemFontOfSize:30 weight:0.2]];
    if (IS_IPAD)
        [LblNumberScore setFont:[UIFont systemFontOfSize:35 weight:0.2]];
    else if(IS_IPHONE_4_OR_LESS)
        [LblNumberScore setFont:[UIFont systemFontOfSize:28 weight:0.2]];
    
    [LblNumberScore setText:[NSString stringWithFormat:@"%li", (long)[[Configuration GetSingleton] GetScore]]];
    
    //
    //ViewInfo
    //
    frm = ViewHeader.frame;
    frm.origin.y = ViewHeader.frame.origin.y + ViewHeader.frame.size.height;
    ViewInfo.frame = frm;
    [ViewInfo setBackgroundColor:[UIColor clearColor]];
    
    //LblAnimal
    frm.size.width = ViewInfo.frame.size.width;
    frm.size.height = 1.0/5 * ViewInfo.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = 0;
    LblAnimal.frame = frm;
    [LblAnimal setTextColor:[UIColor blackColor]];
    [LblAnimal setFont:[UIFont systemFontOfSize:30 weight:0.2]];
    if (IS_IPAD)
    {
        [LblAnimal setFont:[UIFont systemFontOfSize:35 weight:0.2]];
    }
    else if(IS_IPHONE_4_OR_LESS)
        [LblAnimal setFont:[UIFont systemFontOfSize:28 weight:0.2]];
    
    [LblAnimal setTextAlignment:NSTextAlignmentCenter];
    NSString *l_nameofnanimal = [self GetNameOfAnimal:[[Configuration GetSingleton]GetScore ]];
    NSString *l_NAMEOFANIMAL = [l_nameofnanimal uppercaseString];
    [LblAnimal setText:l_NAMEOFANIMAL];
    
    //LblDiscription
    frm.size.width = ViewInfo.frame.size.width;
    frm.size.height = ViewInfo.frame.size.height - LblAnimal.frame.size.height;
    frm.origin.x = 0;
    frm.origin.y = LblAnimal.frame.origin.y + LblAnimal.frame.size.height;
    LblDiscription.frame = frm;
    [LblDiscription setTextColor:[UIColor darkGrayColor]];
    [LblDiscription setFont:[UIFont systemFontOfSize:13 weight:0.2]];
    if (IS_IPAD) {
        [LblDiscription setFont:[UIFont systemFontOfSize:18 weight:0.2]];
    }else if(IS_IPHONE_4_OR_LESS)
        [LblDiscription setFont:[UIFont systemFontOfSize:11 weight:0.2]];
    
    [LblDiscription setTextAlignment:NSTextAlignmentCenter];
    NSString *l_descriptionofanimal = [self GetDescriptionOfAnimal:[[Configuration GetSingleton]GetScore ]];
    [LblDiscription setText:l_descriptionofanimal];
    //
    //ViewController
    //
    frm.size.width = ViewInfo.frame.size.width;
    frm.size.height = SCREEN_HEIGHT - ViewFooter.frame.size.height - ViewHeader.frame.size.height - ViewInfo.frame.size.height;
    frm.origin.y = ViewInfo.frame.origin.y + ViewInfo.frame.size.height;
    frm.origin.x = ViewInfo.frame.origin.x;
    ViewController.frame = frm;
    [ViewController setBackgroundColor:[UIColor clearColor]];
    
    //ImageView
    //frm.size.width = 1.0/3 * (ViewController.frame.size.width);
    frm.size.height = 1.0/2 * ( 0.8 * ViewController.frame.size.height);
    frm.size.width = frm.size.height;
    frm.origin.x = 1.0/2 * (ViewController.frame.size.width - frm.size.width);
    frm.origin.y = 0;
    ImageViewAnimal.frame = frm;
    [ImageViewAnimal setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", l_nameofnanimal]]];
    
    //ShareButton
    frm.size.width = 3.0/8 * ViewController.frame.size.width - 5;
    frm.size.height = 1.0/4 * ( 0.8 * ViewController.frame.size.height);
    frm.origin.x = 1.0/2 * (ViewController.frame.size.width - 2 *frm.size.width - 10);
    frm.origin.y = ImageViewAnimal.frame.origin.y + ImageViewAnimal.frame.size.height; //+ 0.05 * ViewController.frame.size.height;
    BtnShare.frame = frm;
    BtnShare.layer.cornerRadius = 0.1 * BtnShare.frame.size.height;
    //[BtnShare setBackgroundColor:[UIColor yellowColor]];
    [BtnShare setBackgroundColor:[UIColor colorWithRed:255/255.0 green:153/255.0 blue:0/255.0 alpha:1]];
    [BtnShare setTintColor:[UIColor whiteColor]];
    [BtnShare.titleLabel setFont:[UIFont systemFontOfSize:20 weight:0.3]];
    if (IS_IPAD)
    {
        [BtnShare.titleLabel setFont:[UIFont systemFontOfSize:25 weight:0.3]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        //[LblNumberScore setFont:[UIFont systemFontOfSize:18 weight:0.2]];
        [BtnShare.titleLabel setFont:[UIFont systemFontOfSize:15 weight:0.3]];
    }
    
    [BtnShare setTitle:@"SHARE" forState:UIControlStateNormal];
    [BtnShare addTarget:self action:@selector(ShareClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //InviteButton
    frm = BtnShare.frame;
    frm.origin.x = BtnShare.frame.origin.x + BtnShare.frame.size.width + 10;
    BtnInvite.frame = frm;
    BtnInvite.layer.cornerRadius = 0.1 * BtnShare.frame.size.height;
    //[BtnShare setBackgroundColor:[UIColor yellowColor]];
    [BtnInvite setBackgroundColor:[UIColor colorWithRed:255/255.0 green:153/255.0 blue:0/255.0 alpha:1]];
    [BtnInvite setTintColor:[UIColor whiteColor]];
    [BtnInvite.titleLabel setFont:[UIFont systemFontOfSize:20 weight:0.3]];
    if (IS_IPAD)
    {
        [BtnInvite.titleLabel setFont:[UIFont systemFontOfSize:25 weight:0.3]];
    }
    else if(IS_IPHONE_4_OR_LESS)
    {
        //[LblNumberScore setFont:[UIFont systemFontOfSize:18 weight:0.2]];
        [BtnInvite.titleLabel setFont:[UIFont systemFontOfSize:15 weight:0.3]];
    }
    
    [BtnInvite setTitle:@"INVITE" forState:UIControlStateNormal];
    [BtnInvite addTarget:self action:@selector(InviteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //PlayButton
    frm = BtnShare.frame;
    frm.size.width *= 2;
    frm.size.width += 10;
    frm.origin.y = BtnShare.frame.origin.y + BtnShare.frame.size.height + 0.025 * ViewController.frame.size.height;
    BtnPlayAgain.frame = frm;
    BtnPlayAgain.layer.cornerRadius = 0.1 * BtnPlayAgain.frame.size.height;
    [BtnPlayAgain setBackgroundColor:[UIColor colorWithRed:76/255.0 green:157/255.0 blue:231/255.0 alpha:1]];
    [BtnPlayAgain setTintColor:[UIColor whiteColor]];
    [BtnPlayAgain.titleLabel setFont:[UIFont systemFontOfSize:20 weight:0.3]];
    if (IS_IPAD)
        [BtnPlayAgain.titleLabel setFont:[UIFont systemFontOfSize:25 weight:0.3]];
    else if(IS_IPHONE_4_OR_LESS)
        [LblNumberScore setFont:[UIFont systemFontOfSize:18 weight:0.2]];
    
    [BtnPlayAgain setTitle:@"PLAY AGAIN" forState:UIControlStateNormal];
}

- (IBAction) ShareClick: (id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    NSString * message = @"This is my color vision :)";
    UIImage * image = [[Configuration GetSingleton] TakeScreenshot];
    
    NSArray * shareItems = @[message, image];
    UIActivityViewController * ActivityVC = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    
//    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
//                                   UIActivityTypePrint,
//                                   UIActivityTypeAssignToContact,
//                                   UIActivityTypeSaveToCameraRoll,
//                                   UIActivityTypeAddToReadingList,
//                                   UIActivityTypePostToFlickr,
//                                   UIActivityTypePostToVimeo];
//    
//    ActivityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:ActivityVC animated:YES completion:nil];
    
}


- (IBAction) InviteClick: (id)sender
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Facebook already login with token: %@", [[FBSDKAccessToken currentAccessToken] tokenString]);
        FBSDKGameRequestContent *gameRequestContent = [[FBSDKGameRequestContent alloc] init];
        gameRequestContent.message = @"Test your color vision with this game";
        gameRequestContent.title = @"Test Eyes";
        [FBSDKGameRequestDialog showWithContent:gameRequestContent delegate:self];
    }
    else
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithPublishPermissions:@[@"publish_actions"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error)
             {
                 // Process error
                 NSLog(@"Facebook login is error: %@", error);
             }
             else if (result.isCancelled)
             {
                 // Handle cancellations
                 NSLog(@"Facebook login is cancelled");
             }
             else
             {
                 NSLog(@"Facebook login request publish_actions ok: %@", result.grantedPermissions);
                 FBSDKGameRequestContent *gameRequestContent = [[FBSDKGameRequestContent alloc] init];
                 gameRequestContent.message = @"Test your color vision with this game";
                 gameRequestContent.title = @"Test Eyes";
                 [FBSDKGameRequestDialog showWithContent:gameRequestContent delegate:self];

            }
         }];
    }
    
    
}

- (IBAction)PlayAgainClick:(id)sender {
    [[SoundController GetSingleton] PlayClickButton];
}

- (NSString*)GetNameOfAnimal : (NSInteger) p_score
{
    if (p_score <= 4 && p_score >=0)
    {
        return @"bat";
    }
    else if (p_score <= 9 && p_score >=5)
    {
        return @"mole";
    }
    else if (p_score <= 14 && p_score >=10)
    {
        return @"dog";
    }
    else if (p_score <= 19 && p_score >=15)
    {
        return @"cat";
    }
    else if (p_score <= 24 && p_score >=20)
    {
        return @"tiger";
    }
    else if (p_score <= 29 && p_score >= 25)
    {
        return @"hawk";
    }
    else if (p_score <= 34 && p_score >= 30)
    {
        return @"robot";
    }
    else if (p_score >= 35)
    {
        return @"superman";
    }
    
    return @"";
}


- (NSString*)GetDescriptionOfAnimal : (NSInteger) p_score
{
    if (p_score <= 4 && p_score >=0)
    {
        return @"Your color vision is not something to write home about. Bats live in the dark and rely on other senses than sight, and that's what you should do too.";
    }
    else if (p_score <= 9 && p_score >=5)
    {
        return @"You have moderate color vision. You see your closest perimeter but don't go on any big adventure as you will probably get lost.";
    }
    else if (p_score <= 14 && p_score >=10)
    {
        return @"You have decent color vision. You see most of the sticks that are thrown to you but sometimes you're just lost.";
    }
    else if (p_score <= 19 && p_score >=15)
    {
        return @"You have good color vision. The mice should hide when you're on the move.";
    }
    else if (p_score <= 24 && p_score >=20)
    {
        return @"Your color vision is superb. You wouldn't have any problems surviving in the jungle. You can see when the neighbouring tiger visits the bathroom far away.";
    }
    else if (p_score <= 29 && p_score >= 25)
    {
        return @"Wow, you have excellent color vision. You can see a worm from the top of a tree.";
    }
    else if (p_score <= 34 && p_score >= 30)
    {
        return @"Can beleive, Are you a robot ?";
    }
    else if (p_score >= 35)
    {
        return @"I sure that you're a superman !";
    }
    
    return @"";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma -delegate facebook
-(void) sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"Done shared");
}

- (void) sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"Share cancelled");
}

- (void) sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"Share failed");
}

- (void) gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didCompleteWithResults:(NSDictionary *)results
{
    NSLog(@"Invite frined successful: %@", results);
}

- (void) gameRequestDialog:(FBSDKGameRequestDialog *)gameRequestDialog didFailWithError:(NSError *)error
{
    NSLog(@"Invite frined error: %@", error);
}

- (void)gameRequestDialogDidCancel:(FBSDKGameRequestDialog *)gameRequestDialog
{
    NSLog(@"Invite frined cancelled");
}

@end
