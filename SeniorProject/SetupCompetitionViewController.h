//
//  SetupCompetitionViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 2/18/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupCompetitionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *frequencyControl;
@property (weak, nonatomic) IBOutlet UITextField *cyclesNumField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *eliminationControl;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;

@property (weak, nonatomic)NSDate *startDate;


@property (weak, nonatomic) IBOutlet UITextField *cycleNumField;

- (void)setupCompetitionSuccess:(NSString *)msg;
- (void)setupCompetitionFailed:(NSString *)msg;


@end
