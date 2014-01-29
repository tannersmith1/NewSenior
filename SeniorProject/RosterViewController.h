//
//  RosterViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/29/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterViewController : UIViewController

@property (nonatomic,strong)NSArray *teamArray;
@property (nonatomic,weak)IBOutlet UITableView *teamsTable;
@property (nonatomic, strong)NSString *selectedMember;
@end
