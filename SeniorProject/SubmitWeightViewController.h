//
//  SubmitWeightViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 2/18/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitWeightViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;

- (void)submitWeightSuccess:(NSString *)msg;
- (void)submitWeightFailed:(NSString *)msg;

@end
