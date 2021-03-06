//
//  SLAssignmentViewController.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/7/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLAssignmentViewController.h"

#import "SLDetailViewControllerContainer.h"
#import "SLDetailViewController.h"

@interface SLAssignmentViewController () {
//    NSMutableArray *_objects;
}
@property (strong, nonatomic) SLAccount *account;

-(void)configureView;
@end

@implementation SLAssignmentViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Work before the view appears
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

//Work after the view appears
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = YES;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < 5; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    [_objects insertObject:s atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */
 

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_account.assignments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLAssignmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Ass" forIndexPath:indexPath];
    
    SLAssignment *assignment = _account.assignments[indexPath.row];
    
    cell.title.text = [assignment.name uppercaseString];
    cell.score.text = assignment.grade;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
 */

#pragma mark - Table View Delegate

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SLAssignmentTableViewCell *cell = (SLAssignmentTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//    [cell configureView];
//}


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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SLAssignment *assignment = _account.assignments[indexPath.row];
        [[segue destinationViewController] setAssignment:assignment];
//        SLDetailViewController *detailVC = (SLDetailViewController*)([[segue destinationViewController] viewControllers][0]);
//        [detailVC setAssignment:assignment];
    }
}

#pragma mark - Managing the assignment item

- (void)setAccount:(SLAccount *)account
{
    if (_account != account) {
        _account = account;
        [_account openSession];
        [_account updateAssignments];
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.account) {
//        self.assignmentDescriptionLabel.text = [self.assignmentItem description];
    }
    self.navigationItem.title = _account.className;
    
//    [self prepareTestContent];
}

/*
- (void)prepareTestContent
{
    NSInteger num = 10;
    while (num!=0) {
        num--;
        [self insertNewObject:nil]; //insert ten times
    }
}
 */

@end
