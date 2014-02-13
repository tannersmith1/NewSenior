//
//  TeamCreationViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TeamCreationViewController : UIViewController

- (IBAction)createButtonPressed:(id)sender;
- (void)createPartySuccess:(NSString *)msg;
- (void)createPartyFailed:(NSString *)msg;


@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privateSwitcher;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *whirligig;

@end
