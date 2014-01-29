//
//  TeamMenuViewController.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/28/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "TeamMenuViewController.h"
#import "cUserSingleton.h"

@interface TeamMenuViewController ()

@end

@implementation TeamMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    cUserSingleton *user = [cUserSingleton getInstance];
    self.teamNameLabel.text = [NSString stringWithFormat:@"Team name: %@",user.activeParty.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
