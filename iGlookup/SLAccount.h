//
//  SLAccount.h
//  iGlookup
//
//  Created by Leonino Colobong on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FXKeychain.h>
#import <NMSSH.h>
#import "SLAssignment.h"

@interface SLAccount : NSObject

@property NSMutableArray* assignments;
@property NSString* className;
@property NSString* username;
@property FXKeychain* keychain;
@property NMSSHSession* session;

- (id)initWithClassName:(NSString *) className
               username:(NSString *) username;
- (id) initFromDictionary:(NSMutableDictionary*) dictionary;
- (void) updateAssignments;
- (void) updateUsername:(NSString *) username
               password:(NSString *) password;
- (void) setPassword:(NSString *)password;
- (BOOL) openSession;
- (void) closeSession;
- (NSMutableDictionary *)accountToDictionary;
@end
