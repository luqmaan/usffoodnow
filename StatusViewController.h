//
//  StatusViewController.h
//  USFDining
//
//  Created by Josh Bogart on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Restaurant.h"
#import "AppDelegate.h"

@interface StatusViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    // UI Elements
    IBOutlet UITableView *statusView;
    IBOutlet RestaurantCellView *defaultCellStyleView;
    
    // Data
    NSMutableArray *openRestaurants, *closedRestaurants;
}
- (Restaurant*)SelectedRestaurant;
@end
