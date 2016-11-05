//  LTAWebAPIHandler.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTAWebAPIHandler.h"

@implementation LTAWebAPIHandler

+ (void)getRestaurantData:(void (^)(NSData *restaurantData))completion
{
    NSString *urlString = @"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json";
    NSURL *url = [NSURL URLWithString:urlString];
        
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)
        {
            return completion(data);
        }
        else
        {
            NSLog(@"%@", error);
            return completion(nil);
        }
    }];
    
    [dataTask resume];
}

@end
