//
//  cPlayerManager.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/23/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface cPlayerManager : NSObject

@property (nonatomic,weak)id delegate;

- (void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password;
- (void)registerWithUsername:(NSString *)username AndPassword:(NSString *)password;

@end
