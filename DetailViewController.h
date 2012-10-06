//
//  DetailViewController.h
//  USFDining
//
//  Created by Josh Bogart on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"
#import "Restaurant.h"
#import "AppDelegate.h"

@class Restaurant;
@class StatusViewController;
@class TimeTableViewCell;
@interface DetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIImageView *restaurantImageView;
    IBOutlet UITableView *scheduleTableView;
    
    Restaurant *restaurant;
    IBOutlet UILabel *openLabel;
    IBOutlet UILabel *closedLabel;
    IBOutlet UILabel *nameLabel;
    IBOutlet TimeTableViewCell *defaultTimeCellStyle;
}
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil restaurant:(Restaurant*)restuarauntToUse;
@end


@interface TimeTableViewCell : UITableViewCell <NSCoding> {
@public
    IBOutlet UILabel *openLabel;
    IBOutlet UILabel *closeLabel;
    IBOutlet UILabel *dayLabel;
    IBOutlet UILabel *dashLabel;
}
@end