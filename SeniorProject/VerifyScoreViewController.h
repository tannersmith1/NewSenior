//
//  VerifyScoreViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 2/25/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cScoreSheet.h"

@interface VerifyScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *weightField;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageField;
@property (strong, nonatomic)cScoreSheet *sheet;

- (void)verifyWeightSuccess:(NSString *)msg;
- (void)verifyWeightFailed:(NSString *)msg;

@end
