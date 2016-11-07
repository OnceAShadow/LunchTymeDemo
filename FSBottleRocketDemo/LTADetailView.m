//  LTADetailView.m
//  FSBottleRocketDemo
//
//  Created by Fred Sevillano on 11/4/16.
//  Copyright © 2016 Fred Sevillano All rights reserved.

#import "LTADetailView.h"
#import "LTARestaurant.h"

@interface LTADetailView ()

@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *restaurantCategory;
@property (weak, nonatomic) IBOutlet UILabel *addressPartOne;
@property (weak, nonatomic) IBOutlet UILabel *addressPartTwo;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *twitterName;

- (void)setupRestaurantMap;

@end

@implementation LTADetailView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_restaurantName setText:_restaurant.name];
    [_restaurantCategory setText:_restaurant.category];
    [_addressPartOne setText:_restaurant.address];
    [_addressPartTwo setText:[NSString stringWithFormat:@"%@, %@ %@", _restaurant.city, _restaurant.state, _restaurant.postalCode]];
    [_phoneNumber setText:_restaurant.phone];
    [_twitterName setText:[NSString stringWithFormat:@"@%@",_restaurant.twitter]];
  
    [self setupRestaurantMap];
}

- (void)setupRestaurantMap
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)returnButton:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
