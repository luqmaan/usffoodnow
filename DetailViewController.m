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
    [scheduleTableView setDelegate:self];
    [scheduleTableView setDataSource:self];
}

- (void) viewWillAppear:(BOOL)animated // Set the active restuarant
{
    //NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    //[menuTableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
    [openLabel setText:restaurant->open];
    [closedLabel setText:restaurant->close];
    [nameLabel setText:restaurant->name];
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
    return restaurant->times.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return restaurant->name;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:defaultTimeCellStyle];
    TimeTableViewCell *cell = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
    NSString *openTime = ((Time*)[restaurant->times objectAtIndex:indexPath.row])->open;
    NSString *closeTime = ((Time*)[restaurant->times objectAtIndex:indexPath.row])->close;
    
    if (![openTime isEqualToString:@"Closed"])
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        NSDate *openDate = [dateFormat dateFromString:openTime]; 
        NSDate *closeDate = [dateFormat dateFromString:closeTime]; 
        
        // Convert date object to desired output format
        [dateFormat setDateFormat:@"h:mm a"];
        openTime = [dateFormat stringFromDate:openDate];
        if (![closeTime isEqualToString:@"No Close"])  
            closeTime = [dateFormat stringFromDate:closeDate];
        [cell->dashLabel setText:@"-"];
        [cell->openLabel setText:openTime];
        [cell->closeLabel setText:closeTime];
    }
    else
    {
        [cell->dashLabel setText:@"Closed"];
        [cell->openLabel setText:@""];
        [cell->closeLabel setText:@""];
    }
    
    [cell->dayLabel setText:((Time*)[restaurant->times objectAtIndex:indexPath.row])->day];
    //cell.textLabel.text = [restaurant->menuItems objectAtIndex:indexPath.row];
    return cell;
}

@end

@implementation TimeTableViewCell
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:dayLabel forKey:@"dayLabel"];
    [aCoder encodeObject:openLabel forKey:@"openLabel"];
    [aCoder encodeObject:closeLabel forKey:@"closeLabel"];
    [aCoder encodeObject:dashLabel forKey:@"dashLabel"];
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        dayLabel = [aDecoder decodeObjectForKey:@"dayLabel"];
        openLabel = [aDecoder decodeObjectForKey:@"openLabel"];
        closeLabel = [aDecoder decodeObjectForKey:@"closeLabel"];
        dashLabel = [aDecoder decodeObjectForKey:@"dashLabel"];
    }
    return self;
}
@end


