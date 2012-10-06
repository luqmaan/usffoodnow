//
//  StatusViewController.h
//  USFDining
//
//  Created by Josh Bogart on 10/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
@class DetailViewController;
@interface RestaurantCellView : UITableViewCell<NSCoding> {
@public
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *descriptionLabel;
}
@end

@interface Restaurant : NSObject {
@public
    NSString *name;
    NSString *description;
    UIImage *image;
    NSMutableArray *menuItems;
}
@end

@interface StatusViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    // UI Elements
    IBOutlet UITableView *statusView;
    IBOutlet RestaurantCellView *defaultCellStyleView;
    IBOutlet DetailViewController *detailViewController;
    
    // Data
    NSMutableArray *openRestaurants, *closedRestaurants;
}
- (Restaurant*)SelectedRestaurant;
@end
