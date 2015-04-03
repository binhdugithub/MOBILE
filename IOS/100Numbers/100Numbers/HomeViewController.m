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

@property (weak, nonatomic) IBOutlet UIButton *m_UIButtonSpeaker;

@end

@implementation HomeViewController
@synthesize m_UIButtonSpeaker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self ShowSpeaker];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)SinglePlayerClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
    [self performSegueWithIdentifier:@"SegueSinglePlayer" sender:self];
}

- (IBAction)TwoPlayersClick:(id)sender
{
    [[SoundController GetSingleton] PlayClickButton];
}

- (IBAction)AboutClick:(id)sender
{
   [[SoundController GetSingleton] PlayClickButton];
}

- (void) ShowSpeaker
{
    if ([[SoundController GetSingleton] GetMute])
    {
        NSLog(@"Mute");
        [m_UIButtonSpeaker setImage:[UIImage imageNamed:@"btn_mute.png"] forState: UIControlStateNormal];
    }
    else
    {
        NSLog(@"UnMute");
        [m_UIButtonSpeaker setImage:[UIImage imageNamed:@"btn_unmute.png"] forState: UIControlStateNormal];
    }
}

- (IBAction)SpeakerClick:(id)sender
{
   [[SoundController GetSingleton] PlayClickButton];
    [[SoundController GetSingleton] ChangeMute];
    [self ShowSpeaker];
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
