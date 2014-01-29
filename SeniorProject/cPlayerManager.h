//
//  cPlayerManager.h
//  SeniorProject
//
//  Created by Tanner Smith on 1/23/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cPlayerManager : NSObject


- (void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password;
- (void)registerWithUsername:(NSString *)username AndPassword:(NSString *)password;

@end
