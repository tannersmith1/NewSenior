//
//  RegisterViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/14/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisterDelegate
- (void)registerSuccess:(NSString *)text;
- (void)registerFailed:(NSString *)msg;
@end

@interface RegisterViewController : UIViewController <RegisterDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordField;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *whirligig;

- (void)registerSuccess:(NSString *)text;
- (void)registerFailed:(NSString *)msg;
@end
