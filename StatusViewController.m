//
//  StatusViewController.m
//  USFDining
//
//  Created by Josh Bogart on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusViewController.h"

@implementation Restaurant 
- (id) init
{
    self = [super init];
    menuItems = [[NSMutableArray alloc] init];
    return self;
}
@end

@implementation RestaurantCellView 
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:nameLabel forKey:@"nameLabel"];
    [aCoder encodeObject:descriptionLabel forKey:@"descriptionLabel"];
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        nameLabel = [aDecoder decodeObjectForKey:@"nameLabel"];
        descriptionLabel = [aDecoder decodeObjectForKey:@"descriptionLabel"];
    }
    return self;
}
@end

@implementation StatusViewController

- (void) viewDidLoad
{
    openRestaurants = [[NSMutableArray alloc] init];
    closedRestaurants = [[NSMutableArray alloc] init];
    
    // Table view setup
    [statusView setDelegate:self];
    [statusView setDataSource:self];
    
    
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
    detailViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:detailViewController animated:YES];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return defaultCellStyleView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:defaultCellStyleView];
    RestaurantCellView *cell = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    
    Restaurant *restaurant = nil;
    restaurant = (indexPath.section == 0) ? 
    [openRestaurants objectAtIndex:indexPath.row] : [closedRestaurants objectAtIndex:indexPath.row];
    
    cell->nameLabel.text = restaurant->name;
    cell->descriptionLabel.text = restaurant->description;
    cell->imageView = [[UIImageView alloc] initWithImage:restaurant->image];
    cell->imageView.frame = defaultCellStyleView.imageView.frame;
    [cell addSubview:cell->imageView];    
    return cell;
}

@end
