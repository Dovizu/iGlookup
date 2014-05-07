//
//  SLDetailViewController.h
//  iGlookup
//
//  Created by Donny Reynolds on 5/7/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
