//  LTAWebAPIHandler.h
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import <Foundation/Foundation.h>

@interface LTAWebAPIHandler : NSObject

+ (void)getRestaurantData:(void (^)(NSData *restaurantData))completion;

@end


