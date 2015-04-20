//
//  ViewController.m
//  InsertDoDanGian
//
//  Created by Binh Du  on 4/19/15.
//  Copyright (c) 2015 Binh Du . All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtQuestion;
@property (weak, nonatomic) IBOutlet UITextField *txtEKey;
@property (weak, nonatomic) IBOutlet UITextField *txtVKey;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"DoDanGian.sql"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exitKeyboard:(id)sender
{
    [self.txtVKey resignFirstResponder];
    [self.txtEKey resignFirstResponder];
    [self.txtQuestion resignFirstResponder];
}

- (IBAction)SaveCauDo:(id)sender
{
    // Prepare the query string.
    NSString *query = [NSString stringWithFormat:@"insert into CauDo values('%@', '%@', '%@')", self.txtQuestion.text, self.txtEKey.text, self.txtVKey.text];
    
    NSLog(@"Query: %@", query);
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0)
    {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Pop the view controller.
        //[self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NSLog(@"Could not execute the query.");
    }
}
- (IBAction)ViewData:(id)sender {
    // Form the query.
    NSString *query = @"select * from CauDo";
    
   
    NSArray *array = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    for(NSArray *MyArray in array)
    {
    
        NSInteger indexOfQuestiong = [self.dbManager.arrColumnNames indexOfObject:@"Question"];
        NSInteger indexOfEKey = [self.dbManager.arrColumnNames indexOfObject:@"EKey"];
        NSInteger indexVKey = [self.dbManager.arrColumnNames indexOfObject:@"VKey"];
    
        NSString *question = [NSString stringWithFormat:@"%@",[MyArray objectAtIndex:indexOfQuestiong]];
        NSString *eKey = [NSString stringWithFormat:@"%@",[MyArray objectAtIndex:indexOfEKey]];
        NSString *vKey = [NSString stringWithFormat:@"%@",[MyArray objectAtIndex:indexVKey]];
        
        NSLog(@"%@ | %@ | %@", question, eKey, vKey);
    }

}

@end
