//
//  Restaurant.m
//  usffoodnow
//
//  Created by Ricky Joudrey on 10/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Restaurant.h"

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