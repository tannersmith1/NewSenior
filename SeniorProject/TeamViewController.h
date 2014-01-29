//
//  TeamViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/23/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSArray *teamArray;
}
@property (weak, nonatomic) IBOutlet UITableView *teamsTable;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;

@end
