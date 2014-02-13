//
//  RosterViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/29/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *deleteMemberButton;
@property (nonatomic,strong)NSArray *teamArray;
@property (nonatomic,weak)IBOutlet UITableView *teamsTable;
@property (nonatomic, strong)NSString *selectedMember;

- (void)deleteMemberSuccess:(NSString *)msg;
- (void)deleteMemberFailed:(NSString *)msg;
@end
