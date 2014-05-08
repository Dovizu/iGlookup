//
//  SLAssignmentTableViewCell.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLAssignmentTableViewCell.h"

@implementation SLAssignmentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
//    [self.score sizeToFit];
//    [self needsUpdateConstraints];
    [self configureView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureView
{
    CALayer *scoreLayer = self.score.layer;
    scoreLayer.masksToBounds = YES;
    scoreLayer.cornerRadius = 8;
    scoreLayer.borderWidth = 1;
    scoreLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    scoreLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    self.score.textColor = [UIColor whiteColor];
}

@end
