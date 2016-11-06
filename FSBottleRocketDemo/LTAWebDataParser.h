//  LTAWebDataParser.h
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import <Foundation/Foundation.h>

@protocol LTAWebDataParserDelegate <NSObject>

- (void)updateData:(NSMutableArray *)parsedData;

@end

@interface LTAWebDataParser : NSObject

@property (nonatomic, weak) id<LTAWebDataParserDelegate> delegate;

- (void)parseRestaurantData:(NSData *)data;

@end
