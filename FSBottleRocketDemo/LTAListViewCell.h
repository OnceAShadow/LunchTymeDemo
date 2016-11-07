//  LTAListViewCell.h
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/5/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import <UIKit/UIKit.h>

@interface LTAListViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gradientView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCategory;

@end
