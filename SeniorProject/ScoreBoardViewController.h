//
//  ScoreBoardViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 2/25/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreBoardViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)NSMutableArray *scoreArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)getScoreBoardSuccess:(NSArray *)scores;
- (void)getScoreBoardFailed:(NSString *)msg;

@end
