//
//  JoinTeamViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/24/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinTeamViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *teamNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
- (IBAction)joinButtonPressed:(id)sender;

@end
