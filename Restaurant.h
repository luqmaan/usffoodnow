//
//  Restaurant.h
//  usffoodnow
//
//  Created by Ricky Joudrey on 10/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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
