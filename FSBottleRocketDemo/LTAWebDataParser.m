//  LTAWebDataParser.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTAWebDataParser.h"
#import "LTARestaurant.h"
#import "LTAWebAPIHandler.h"

@implementation LTAWebDataParser

- (void)parseRestaurantData:(NSData *)data
{
    NSMutableArray *restaurants = [NSMutableArray new];
    NSError *error;
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if(error)
    {
        NSLog(@"Error With Serialization!");
    }
    else
    {
        NSDictionary *array = root[@"restaurants"];
        
        for (NSDictionary *resto in array)
        {
            // Requires at least a name to be added to the Array of Restaurants.
            if (![[resto valueForKey:@"name"] isEqual:[NSNull null]])
            {
                LTARestaurant *restaurant = [[LTARestaurant alloc] initWithName:[resto valueForKey:@"name"]];
            
                [restaurant setImageURL:[resto valueForKey:@"backgroundImageURL"]];
                [restaurant setCategory:[resto valueForKey:@"category"]];
                
                // id is used to check is Dictionary is valid.
                id contact = resto[@"contact"];
                if([contact isKindOfClass:[NSDictionary class]])
                {
                    if( [contact objectForKey:@"formattedPhone"])
                    {
                        [restaurant setPhone:[contact valueForKey:@"formattedPhone"]];
                    }
                    
                    if( [contact objectForKey:@"twitter"])
                    {
                        [restaurant setTwitter:[NSString stringWithFormat:@"@%@",[contact valueForKey:@"twitter"]]];
                    }
                }
                
                id location = resto[@"location"];
                if([location isKindOfClass:[NSDictionary class]])
                {
                    if([location objectForKey:@"address"])
                    {
                        [restaurant setAddress:[location valueForKey:@"address"]];
                    }
                    
                    if([location objectForKey:@"postalCode"])
                    {
                        [restaurant setPostalCode:[location valueForKey:@"postalCode"]];
                    }
                    
                    if([location objectForKey:@"city"])
                    {
                        [restaurant setCity:[location valueForKey:@"city"]];
                    }
                    
                    if([location objectForKey:@"state"])
                    {
                        [restaurant setState:[location valueForKey:@"state"]];
                    }
                    
                    [restaurant setLat:[[location valueForKey:@"lat"]doubleValue]];
                    [restaurant setLng:[[location valueForKey:@"lng"]doubleValue]];
                }
            
                [restaurants addObject:restaurant];
            }
        }
        
        // Once parsing is finished dispatch to the main thread for UI Update.
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate updateData:restaurants];
        });
    }
}

@end
