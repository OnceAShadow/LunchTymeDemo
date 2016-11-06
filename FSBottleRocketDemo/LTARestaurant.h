//  LTARestaurant.h
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTARestaurant : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;

@property (nonatomic) CGFloat lat;
@property (nonatomic) CGFloat lng;

- (instancetype)initWithName:(NSString *)name;

@end
