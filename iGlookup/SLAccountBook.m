//
//  SLAccountBook.m
//  iGlookup
//
//  Created by Leonino Colobong on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLAccountBook.h"

@implementation SLAccountBook

- (id)init
{
    self = [super init];
    if (self) {
        NSString *applicationKey = @"SL-iGlookup";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *settings = [defaults objectForKey:applicationKey];
        if (!settings) {
            //first time boot
            [defaults setObject:@{} forKey:applicationKey];
        }else{
            NSArray *listAccounts = [settings objectForKey:@"Accounts"];
            if (listAccounts) {
                for (NSDictionary *account in listAccounts) {
                    [self addAccount:[[SLAccount alloc] initFromDictionary:account]];
                }
            }
        }
    }
    return self;
}

-(id)initFromDictionary:(NSMutableDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSMutableDictionary* outDictionary = [[NSMutableDictionary alloc] init];
        [outDictionary setObject:_accounts forKey:@"accounts"];
    }
    return self;
}

-(void)updateCurrentAccount
{
    [_currentAccount updateAssignments];
}

- (void)addAccount:(SLAccount*) account
{
    if (!_accounts) {
        _accounts = [[NSMutableArray alloc] init];
    }
    [_accounts addObject:account];
}

-(void)removeAccount:(SLAccount *)account
{
    //Check if account has open session or not. Might not be necessary though
    [_accounts removeObject:account];
}

-(NSDictionary *)accountBookToDictionary
{
    NSDictionary *outDictionary = @{@"accounts": _accounts};
    return outDictionary;
}




@end
