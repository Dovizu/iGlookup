//
//  SLAssignmentTableViewCellLabel.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLAssignmentTableViewCellLabel.h"

@implementation SLAssignmentTableViewCellLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CALayer *scoreLayer = self.layer;
    scoreLayer.masksToBounds = YES;
    scoreLayer.cornerRadius = 8;
    scoreLayer.borderWidth = 1;
    scoreLayer.borderColor = [[UIColor lightGrayColor] CGColor];
    scoreLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
    self.textColor = [UIColor whiteColor];
    
    [super drawRect:rect];
}


@end
