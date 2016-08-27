//
//  TabBarController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//
#import "BuyListViewController.h"
#import "SupplyListViewController.h"
#import "MineViewController.h"

@interface TabBarController : UITabBarController <UITabBarControllerDelegate, UITabBarDelegate>

@property (nonatomic, weak) id            tabBarDelegate;
@property (nonatomic, strong) BuyListViewController* buyListVC;
@property (nonatomic, strong) SupplyListViewController* supplyListVC;
@property (nonatomic, strong) MineViewController* mineVC;


- (BOOL)checkUserLoginOrNot;
- (void)showBadgeValue:(NSString*)number;


@end