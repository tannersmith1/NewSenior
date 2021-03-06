//
//  TeamMenuViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/28/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamMenuViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *whirligig;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIButton *deleteTeamButton;

- (void)deleteSuccess:(NSString *)msg;
- (void)deleteFailed:(NSString *)msg;

@end
