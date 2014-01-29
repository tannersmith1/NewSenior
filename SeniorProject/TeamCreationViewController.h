//
//  TeamCreationViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TeamCreationViewController : UIViewController {
    
}

- (IBAction)createButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privateSwitcher;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;

@end
