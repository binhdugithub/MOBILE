//
//  1ResultViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/2/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "SingleResultViewController.h"
#import "SinglePlayerViewController.h"
#import "SoundController.h"
#import <AVFoundation/AVFoundation.h>


@interface SingleResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *m_UILabelScore;

@property (nonatomic, strong) SoundController *m_Sounder;
@property (nonatomic, strong)NSMutableArray *m_Array100Number;
@property (nonatomic, assign)NSInteger m_CurrentNumber;
@end

@implementation SingleResultViewController
@synthesize m_UILabelScore;
@synthesize m_Sounder;
@synthesize m_Array100Number;
@synthesize m_CurrentNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_Sounder = [[SoundController alloc] init];
    [m_UILabelScore setText:[NSString stringWithFormat:@"%i / 100", m_CurrentNumber]];
    
    
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

- (void)SetArrayNumber: (NSMutableArray*) p_array
{
    m_Array100Number = [[NSMutableArray alloc] init];
    m_Array100Number = p_array;
}

- (void)SetCurrentNumber: (NSInteger) p_index
{
    m_CurrentNumber = p_index;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    

    if ([[segue identifier] isEqualToString:@"SegueBack"])
    {
        SinglePlayerViewController *MyView = (SinglePlayerViewController*)[segue destinationViewController];
        [MyView SetArrayNumber:m_Array100Number];
        [MyView SetStateGame:BACKVIEW];
    }
}


@end
