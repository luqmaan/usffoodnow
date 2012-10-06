//
//  DetailViewController.h
//  USFDining
//
//  Created by Josh Bogart on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"

@class Restaurant;
@class StatusViewController;

@interface DetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIImageView *restaurantImageView;
    IBOutlet StatusViewController *statusViewController;
    IBOutlet UITableView *menuTableView;
    Restaurant *restaurant;
}
- (IBAction)Done;
@end
