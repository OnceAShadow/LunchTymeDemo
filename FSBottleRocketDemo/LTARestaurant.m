//  LTARestaurant.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTARestaurant.h"

@implementation LTARestaurant

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    
    if (self)
    {
        _name = name;
        
        _imageURL = @"";
        _category = @"";
        _phone = @"";
        _twitter = @"";
        _address = @"";
        _postalCode = @"";
        _city = @"";
        _state = @"";
        
        _lat = 0;
        _lng = 0;
    }
    
    return self;
}

@end
