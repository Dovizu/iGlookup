//
//  SLDetailViewController.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/8/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLDetailViewController.h"
#import "SLAssignmentViewController.h"

@interface SLDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UITableViewCell *cardCell;
@property (weak, nonatomic) IBOutlet UILabel *cardScore;
@property (weak, nonatomic) IBOutlet UILabel *cardRank;
@property (weak, nonatomic) IBOutlet UITableViewCell *readerCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *weightCell;

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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *text = @"Comment: The best way that I've found for dynamic height is to calculate the height beforehand and store it in a collection of some sort (probably an array.) Assuming the cell contains";
    
    if ([indexPath section]==1 && [indexPath row]==0) {

        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:[UIFont systemFontSize]];
        cell.textLabel.text = _assignment.comments;
        cell.textLabel.numberOfLines = 0;
        
        //calculate height
        UILabel *gettingSizeLabel = [[UILabel alloc] init];
        gettingSizeLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:[UIFont systemFontSize]];
        gettingSizeLabel.text = _assignment.comments;
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
    self.cardScore.text = _assignment.grade;
    [_assignment updateDistribution];
    NSNumber *num = [_assignment.distribution.numInBin valueForKeyPath:@"@sum.self"];
    self.cardRank.text = [NSString stringWithFormat:@"Rank: #%@ out of %@", [NSNumber numberWithInteger:_assignment.distribution.rank], num];
    self.readerCell.textLabel.text = @"Reader";
    self.readerCell.detailTextLabel.text = _assignment.reader;
    self.weightCell.textLabel.text = @"Weight";
    self.weightCell.detailTextLabel.text = _assignment.weight;
}

- (void)setAssignment:(SLAssignment *)assignment
{
    if (_assignment != assignment) {
        _assignment = assignment;

        // Update the view.
        [self configureView];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[segue destinationViewController] setDistribution:_assignment.distribution];
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
