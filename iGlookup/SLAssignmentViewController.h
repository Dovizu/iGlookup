//
//  SLAssignmentViewController.h
//  iGlookup
//
//  Created by Donny Reynolds on 5/7/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLAssignmentViewController : UITableViewController

@property (strong, nonatomic) id assignmentItem;

@property (weak, nonatomic) IBOutlet UILabel *assignmentDescriptionLabel;
@end
