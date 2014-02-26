//
//  VerifyWeightsViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 2/25/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cScoreSheet.h"

@interface UnverifiedScoreMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *scoreArray;
@property (nonatomic, strong)IBOutlet UITableView *scoreTable;
@property (nonatomic, strong)cScoreSheet *scoreSheet;

- (void)getScoreSheetSuccess:(NSString *)msg;
- (void)getScoreSheetFailed:(NSString *)msg;

@end
