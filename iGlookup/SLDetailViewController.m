//
//  SLDetailViewController.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLDetailViewController.h"

@interface SLDetailViewController ()

@property UITableViewCell *prototypeCell;

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UITableViewCell *cardCell;
@property (weak, nonatomic) IBOutlet UILabel *cardScore;
@property (weak, nonatomic) IBOutlet UILabel *cardRank;

@end

@implementation SLDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    NSString *identifier = @"PrototypeCellIdentifier";
    [self.tableView registerNib:[UINib nibWithNibName:@"PrototypeCell" bundle:nil] forCellReuseIdentifier:identifier];
    self.prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = @"Comment: The best way that I've found for dynamic height is to calculate the height beforehand and store it in a collection of some sort (probably an array.) Assuming the cell contains";
    
    if ([indexPath section]==1 && [indexPath row]==0) {

        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:[UIFont systemFontSize]];
        cell.textLabel.text = text;
        cell.textLabel.numberOfLines = 0;
        
        //calculate height
        UILabel *gettingSizeLabel = [[UILabel alloc] init];
        gettingSizeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:[UIFont systemFontSize]];
        gettingSizeLabel.text = text;
        gettingSizeLabel.numberOfLines = 0;
        CGSize expectedSize = [gettingSizeLabel sizeThatFits:CGSizeMake(self.tableView.frame.size.width, MAXFLOAT)];

        return expectedSize.height + 40;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView
{
    self.cardScore.text = @"85/100";
    self.cardRank.text = [NSString stringWithFormat:@"#%@ out of %@", [NSNumber numberWithInt:23], [NSNumber numberWithInt:534]];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
