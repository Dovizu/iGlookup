//
//  SLAddAccountViewController.h
//  iGlookup
//
//  Created by Donny Reynolds on 5/9/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLAddAccountDelegate <NSObject>

- (void)addAccountClassName:(NSString *)classname login:(NSString *)login andPassword:(NSString *)password;

@end

@interface SLAddAccountViewController : UITableViewController <UITextFieldDelegate>
@property (unsafe_unretained) id <SLAddAccountDelegate> delegate;
@end
