//
//  SetupCompetitionViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 2/18/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "SetupCompetitionViewController.h"
#import "cUserSingleton.h"
#import "cCompetitionManager.h"

@interface SetupCompetitionViewController ()

@end

@implementation SetupCompetitionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)hideKeyboard:(id)sender {
    
    [self.cycleNumField resignFirstResponder];
}

//Hide keyboard if users touches outside keypad
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.cycleNumField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSDate *now = [NSDate date];
	[self.startDatePicker setDate:now animated:YES];
    [self.startDatePicker setMinimumDate:now];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dateValueChanged:(id)sender
{

}

- (void)setupCompetitionSuccess:(NSString *)msg
{
    //[self.whirligig stopAnimating];
    //self.resultsTextView.text = msg;
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];

}

- (void)setupCompetitionFailed:(NSString *)msg
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                          message:msg
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    
    [myAlertView show];

}

- (IBAction)createButtonPressed:(id)sender {

    NSString *freq = [self.frequencyControl titleForSegmentAtIndex:self.frequencyControl.selectedSegmentIndex];
    NSString *elimination = [self.eliminationControl titleForSegmentAtIndex:self.eliminationControl.selectedSegmentIndex];
    NSNumber *cycles = [NSNumber numberWithInt:[self.cycleNumField.text integerValue]];

    NSDateFormatter *dateform = [[NSDateFormatter alloc] init];
    [dateform setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:self.startDatePicker.date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    NSLog(@"%@ %@",dateString, self.startDatePicker.date);
    
    cCompetitionManager *mgr = [[cCompetitionManager alloc] init];
    mgr.delegate = self;
    [mgr createCompStarting:self.startDatePicker.date withFreq:freq andCycles:cycles andElim:elimination];
    
    
    
    NSString *debug = [NSString stringWithFormat:@"%@  %@  %@  %@", freq, elimination, cycles, dateString];
    NSLog(debug);
}



@end
