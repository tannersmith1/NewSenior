//
//  cPartyManager.m
//  SeniorProject
//
//  Created by Tanner Smith on 1/12/14.
//  Copyright (c) 2014 Tanner Smith. All rights reserved.
//

#import "cPartyManager.h"

@implementation cPartyManager

//Makes calls to web service
- (void)createPartyWithName:(NSString *)partyName {
    //Check that the party name is available

    //If the name is available submit it for creation
    
    //Testing
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Hello World!"
                                                      message:partyName
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}



@end
