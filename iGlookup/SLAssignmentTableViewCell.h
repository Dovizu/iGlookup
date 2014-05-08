//
//  SLAssignmentTableViewCell.h
//  iGlookup
//
//  Created by Donny Reynolds on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLAssignmentTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *score;

- (void)configureView;

@end
