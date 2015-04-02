//
//  1ResultViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "SingleResultViewController.h"
#import "SoundController.h"
#import <AVFoundation/AVFoundation.h>


@interface SingleResultViewController ()
@property (nonatomic, strong) SoundController *m_Sounder;
@end

@implementation SingleResultViewController
@synthesize m_Sounder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_Sounder = [[SoundController alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackClick:(id)sender
{
    [m_Sounder PlayClick];
    [self performSegueWithIdentifier:@"SegueBack" sender:self];
}
- (IBAction)HomeClick:(id)sender
{
    [m_Sounder PlayClick];
}

- (IBAction)PlayAgainClick:(id)sender
{
    [m_Sounder PlayClick];
    [self performSegueWithIdentifier:@"SegueBack" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
