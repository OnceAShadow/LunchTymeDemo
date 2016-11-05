//  LTAListView.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTAListView.h"
#import "LTAWebDataParser.h"
#import "LTAWebAPIHandler.h"
#import "LTARestaurant.h"

@interface LTAListView () <LTAWebDataParserDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *restaurantArray;
@property (nonatomic, strong) LTAWebDataParser *dataParser;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation LTAListView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _restaurantArray = [NSArray alloc];
    
    _dataParser = [LTAWebDataParser new];
    _dataParser.delegate = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [LTAWebAPIHandler getRestaurantData:^(NSData *restaurantData) {
            [_dataParser parseRestaurantData:restaurantData];
        }];
    });
}

#pragma Mark: LTAWebDataParser

- (void)updateData:(NSArray *)parsedData
{
    _restaurantArray = parsedData;
    //reload
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
