//
//  ViewController.m
//  100Numbers
//
//  Created by Nguyễn Thế Bình on 4/3/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "StatisticsViewController.h"

@interface StatisticsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelBestScore;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelAverageScore;
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelTimesPlayed;

@end

@implementation StatisticsViewController
@synthesize m_UILabelAverageScore, m_UILabelBestScore, m_UILabelTimesPlayed;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self LoadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)LoadData
{
    NSString *pathData = [[NSBundle mainBundle] pathForResource: @"Data" ofType:@"plist"];
    NSDictionary *dicData = [NSDictionary dictionaryWithContentsOfFile:pathData];
    if (dicData != nil)
    {
        NSInteger l_timesPlayed = [dicData[@"TimesPlayed"] intValue];
        if (l_timesPlayed <= 0)
        {
            m_UILabelBestScore.text = @"--";
            m_UILabelAverageScore.text = @"--";
            m_UILabelTimesPlayed.text = @"--";
        }
        else
        {
           
            m_UILabelBestScore.text = [NSString stringWithFormat:@"%i",
                                       [dicData[@"BestScore"] intValue]];
            m_UILabelAverageScore.text = [NSString stringWithFormat:@"%i",
                                       [dicData[@"AverageScore"] intValue]];
             m_UILabelTimesPlayed.text = [NSString stringWithFormat:@"%i", l_timesPlayed];
        }
        
    }
    else
    {
        NSLog(@"Load User info fail !!");
    }
    
    
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
