//  LTAListView.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTAListView.h"
#import "LTAWebDataParser.h"
#import "LTAWebAPIHandler.h"
#import "LTADetailView.h"
#import "LTAListViewCell.h"
#import "LTARestaurant.h"

@interface LTAListView () <LTAWebDataParserDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *restaurantArray;
@property (nonatomic, strong) LTAWebDataParser *dataParser;
@property (nonatomic, strong) NSCache *imageCache;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation LTAListView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _restaurantArray = [NSMutableArray new];
    _imageCache = [NSCache new];
    
    _dataParser = [LTAWebDataParser new];
    _dataParser.delegate = self;
    
    //Fetch the Web Data on the background thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [LTAWebAPIHandler getRestaurantData:^(NSData *restaurantData) {
            [_dataParser parseRestaurantData:restaurantData];
        }];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"toLunchDetails"])
    {
        LTADetailView *detailView = [segue destinationViewController];
        LTARestaurant *resto = _restaurantArray[[_collectionView indexPathForCell:sender].row];
        
        //We pass the restaurant object to the detailView
        [detailView setRestaurant:resto];
    }
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
    
    cell.imageView.image = nil;
    
    if ([_imageCache objectForKey:resto.imageURL])
    {
        cell.imageView.image = [_imageCache objectForKey:resto.imageURL];
    }
    else
    {
        //Downloading the images in the background
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:resto.imageURL]]];
            
            //Updating the UI on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                
                LTAListViewCell * cell = (LTAListViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                [_imageCache setObject:img forKey:resto.imageURL];
                cell.imageView.image = img;
            });
        });
    }

    return cell;
}

// This is to make sure the cells are as wide as the screen.
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = collectionView.frame.size.width;
    CGFloat height = 180;
    
    return CGSizeMake(width, height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
