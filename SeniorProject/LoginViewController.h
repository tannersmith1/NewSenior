//
//  LoginViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/14/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginDelegate
- (void)loginSuccess;
- (void)loginFailed:(NSString *)msg;
@end

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *whirligig;




- (IBAction)pressedLoginButton:(id)sender;
- (void)loginSuccess;
- (void)loginFailed:(NSString *)msg;

@end
