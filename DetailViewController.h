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

@interface DetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIImageView *restaurantImageView;
    IBOutlet UITableView *menuTableView;
    Restaurant *restaurant;
    IBOutlet UILabel *openLabel;
    IBOutlet UILabel *closedLabel;
    IBOutlet UILabel *nameLabel;
}
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil restaurant:(Restaurant*)restuarauntToUse;
@end
