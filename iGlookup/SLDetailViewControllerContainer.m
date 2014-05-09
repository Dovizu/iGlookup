//
//  SLDetailViewController.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/7/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLDetailViewControllerContainer.h"

@interface SLDetailViewControllerContainer ()
- (void)configureView;
@end

@implementation SLDetailViewControllerContainer

#pragma mark - Managing the detail item

- (void)setAssignment:(id)newDetailItem
{
    if (_assignment != newDetailItem) {
        _assignment = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.assignment) {
//        self.detailDescriptionLabel.text = [NSString stringWithFormat:@"%@ Data Could Not Be Loaded", [self.assignment description]];
    }else{
        
    }
    
}

//Work before the view appears
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
