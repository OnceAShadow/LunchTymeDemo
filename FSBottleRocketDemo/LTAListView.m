//  LTAListView.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTAListView.h"
#import "LTAWebDataParser.h"
#import "LTAWebAPIHandler.h"
#import "LTARestaurant.h"
#import "LTAListViewCell.h"

@interface LTAListView () <LTAWebDataParserDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *restaurantArray;
@property (nonatomic, strong) LTAWebDataParser *dataParser;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation LTAListView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _restaurantArray = [NSMutableArray new];
    
    _dataParser = [LTAWebDataParser new];
    _dataParser.delegate = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [LTAWebAPIHandler getRestaurantData:^(NSData *restaurantData) {
            [_dataParser parseRestaurantData:restaurantData];
        }];
    });
}

#pragma Mark: LTAWebDataParser

- (void)updateData:(NSMutableArray *)parsedData
{
    _restaurantArray = parsedData;
    [_collectionView reloadData];
}

#pragma Mark: UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_restaurantArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LTAListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"cellGradientBackground.png"];
    
    LTARestaurant *resto = _restaurantArray[indexPath.row];
    [cell.restaurantName setText:resto.name];
    [cell.restaurantCategory setText:resto.category];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
