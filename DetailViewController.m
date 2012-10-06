//
//  DetailViewController.m
//  USFDining
//
//  Created by Josh Bogart on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

- (void) viewDidLoad
{
    [self setTitle:@"Details"];
    [menuTableView setDelegate:self];
    [menuTableView setDataSource:self];
}

- (void) viewWillAppear:(BOOL)animated // Set the active restuarant
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [menuTableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil restaurant:(Restaurant*)restuarauntToUse
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    restaurant = restuarauntToUse;
    return self;
}

#pragma mark --
#pragma mark UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return restaurant->menuItems.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NULL;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [restaurant->menuItems objectAtIndex:indexPath.row];
    return cell;
}

@end
