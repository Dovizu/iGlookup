//
//  SLAccountBook.h
//  iGlookup
//
//  Created by Leonino Colobong on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLAccount.h"

@interface SLAccountBook : NSObject

@property NSMutableArray* accounts;
@property SLAccount* currentAccount;

- (id)initFromDictionary:(NSMutableDictionary*) dictionary;
- (void)updateCurrentAccount;
- (void)addAccount:(SLAccount*) account;
- (void)removeAccount:(SLAccount *) account;
- (NSDictionary *)accountBookToDictionary;

@end
