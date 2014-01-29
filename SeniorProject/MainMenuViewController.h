//
//  ViewController.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController {
    NSArray *teamArray;
}

@property (nonatomic, weak) IBOutlet UITableView *teamsTable;

@end
