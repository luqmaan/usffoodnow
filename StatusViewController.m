//
//  StatusViewController.m
//  USFDining
//
//  Created by Josh Bogart on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusViewController.h"

@implementation StatusViewController

- (void) viewDidLoad
{
    openRestaurants = [[NSMutableArray alloc] init];
    closedRestaurants = [[NSMutableArray alloc] init];
    [self setTitle:@"Restaurants"];
    
    // Table view setup
    [statusView setDelegate:self];
    [statusView setDataSource:self];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"restaurants.db" ofType:nil];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    [db setLogsErrors:true];
    FMResultSet *results = [db executeQuery:@"select * from restaurants"];
    int weekday = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] weekday];
    int hour = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]] hour];
    // 7 = Saturday Open
	while ([results next]) {
		//retrieve values for each record
        NSString *name = [results stringForColumnIndex:0];
        NSString *open = [results stringForColumnIndex:weekday * 2 - 1];
        NSString *close = [results stringForColumnIndex:weekday * 2];
        if (!open) open = @"Closed";
        if (!close) close = @"Closed";
        
        Restaurant *r = [[Restaurant alloc] init];
        r->name = name;
        r->open = open;
        r->close = close;
        
        if ([open isEqualToString:@"Closed"] || [close isEqualToString:@"Closed"])
            [closedRestaurants addObject:r];
        else
            [openRestaurants  addObject:r];
	}
    
    /*
    // Test data    
    for (int i = 0; i < 10; ++i)
    {
        Restaurant *r = [[Restaurant alloc] init];
        r->name = [NSString stringWithFormat:@"Open Restaurant %d", i];
        r->description = @"Restaurant description";
        r->image = [UIImage imageNamed:@"moes.jpg"];
        for (int j = 0; j < 8; ++j)
            [r->menuItems addObject:[NSString stringWithFormat:@"Item %d", j]];
        [openRestaurants  addObject:r];
    }
    
    for (int i = 0; i < 5; ++i)
    {
        Restaurant *r = [[Restaurant alloc] init];
        r->name = [NSString stringWithFormat:@"Closed Restaurant %d", i];
        r->description = @"Restaurant description";
        r->image = [UIImage imageNamed:@"moes.jpg"];
        for (int j = 0; j < 8; ++j)
            [r->menuItems addObject:[NSString stringWithFormat:@"Item %d", j]];
        [closedRestaurants  addObject:r];
    }
    */
}

- (Restaurant*)SelectedRestaurant { 
    Restaurant *restaurant = nil;
    NSIndexPath *indexPath = statusView.indexPathForSelectedRow;
    restaurant = (indexPath.section == 0) ? 
    [openRestaurants objectAtIndex:indexPath.row] : [closedRestaurants objectAtIndex:indexPath.row];
    return restaurant;
}

#pragma mark --
#pragma mark UITableView Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0) ? openRestaurants.count : closedRestaurants.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? @"Open Restaurants" : @"Closed Restauarants";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINavigationController *navController = appDelegate->navController;
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailsView" bundle:[NSBundle mainBundle] restaurant:[self SelectedRestaurant]];
    [navController pushViewController:detailViewController animated:YES];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return //defaultCellStyleView.frame.size.height;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:defaultCellStyleView];
    RestaurantCellView *cell = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];*/
    
    Restaurant *restaurant = nil;
    restaurant = (indexPath.section == 0) ? 
    [openRestaurants objectAtIndex:indexPath.row] : [closedRestaurants objectAtIndex:indexPath.row];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    /*cell->nameLabel.text = restaurant->name;
    cell->descriptionLabel.text = restaurant->description;
    cell->imageView = [[UIImageView alloc] initWithImage:restaurant->image];
    cell->imageView.frame = defaultCellStyleView.imageView.frame;
    [cell addSubview:cell->imageView]; */  
    [[cell textLabel] setText:restaurant->name];
    return cell;
}

@end
