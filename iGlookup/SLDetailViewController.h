//
//  SLDetailViewController.h
//  iGlookup
//
//  Created by Donny Reynolds on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLAssignment.h"
@interface SLDetailViewController : UITableViewController
@property (nonatomic, strong) SLAssignment *assignment;

- (void)setAssignment:(SLAssignment *)assignment;

@end
