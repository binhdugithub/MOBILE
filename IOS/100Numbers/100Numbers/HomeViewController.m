//
//  ViewController.m
//  100Numbers
//
//  Created by Binh Du  on 4/1/15.
//  Copyright (c) 2015 LapTrinhAlgo.Com. All rights reserved.
//

#import "HomeViewController.h"
#import "SoundController.h"
#import "SinglePlayerViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) SoundController *m_Audio;


@end

@implementation HomeViewController
@synthesize m_Audio;


- (void)viewDidLoad
{
    [super viewDidLoad];
    m_Audio = [[SoundController alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)SinglePlayerClick:(id)sender
{
    [m_Audio PlayClick];
    [self performSegueWithIdentifier:@"SegueSinglePlayer" sender:self];
}

- (IBAction)TwoPlayersClick:(id)sender
{
    [m_Audio PlayClick];
}

- (IBAction)AboutClick:(id)sender
{
    [m_Audio PlayClick];
}

- (IBAction)SpeakerClick:(id)sender
{
   [m_Audio PlayClick];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SegueSinglePlayer"])
    {
        SinglePlayerViewController *MySinglePlayer = (SinglePlayerViewController *)[segue destinationViewController];
        [MySinglePlayer SetStateGame:FIRSTWIEW];
    }
    
}
@end
