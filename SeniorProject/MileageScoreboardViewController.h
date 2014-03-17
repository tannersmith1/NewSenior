//
//  MileageScoreboardViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 3/16/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MileageScoreboardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)NSMutableArray *scoreArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)getScoreBoardSuccess:(NSArray *)scores;
- (void)getScoreBoardFailed:(NSString *)msg;

@end


