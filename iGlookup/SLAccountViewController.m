//
//  SLMasterViewController.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/7/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLAccountViewController.h"
#import "SLAccountBook.h"

@interface SLAccountViewController () {
    SLAccountBook *accountBook;
}
@end

@implementation SLAccountViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    accountBook = [[SLAccountBook alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self setToolbarItems:[NSArray arrayWithObjects:self.editButtonItem, nil]];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount:)];
    self.navigationItem.rightBarButtonItem = addButton;

//    [self prepareTestContent];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
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

- (void)addAccount:(id)sender
{
    [self performSegueWithIdentifier:@"addAccountScene" sender:sender];
}

- (void)addAccountClassName:(NSString *)classname login:(NSString *)login andPassword:(NSString *)password
{
    DebugLog(@"Account added with classname:%@, login:%@, and password:%@", classname,login,password);
    if (accountBook) {
        SLAccount *account = [[SLAccount alloc] initWithClassName:classname username:login];
        [account setPassword:password];
        [accountBook addAccount:account];
    }
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [accountBook.accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    SLAccount *account = accountBook.accounts[indexPath.row];
    cell.textLabel.text = account.className;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        SLAccount *account = [tableView cellForRowAtIndexPath:indexPath];
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        for (SLAccount *acc in accountBook.accounts) {
            if ([acc.className isEqualToString:cell.textLabel.text]) {
                [accountBook removeAccount:acc];
            }
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAssignment"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SLAccount *account = accountBook.accounts[indexPath.row];
//        [account openSession];
        
        [[segue destinationViewController] setAccount:account];
    }else if ([[segue identifier] isEqualToString:@"addAccountScene"]) {
        SLAddAccountViewController *addAccountVC = ([[segue destinationViewController] viewControllers][0]);
        [addAccountVC setDelegate:self];
    }
}

/*
- (void)prepareTestContent {
    NSInteger num = 3; //accounts
    while (num!=0) {
        [self insertNewObject:nil];
        num--;
    }
}
 */

@end
