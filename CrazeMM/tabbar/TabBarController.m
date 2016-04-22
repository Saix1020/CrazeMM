//
//  TabBarController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "TabBarController.h"
#import "BuyViewController.h"
#import "SellViewController.h"
#import "MineViewController.h"
#import "BaseNavigationController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (id)init
{
    
    self = [super init];
    if(self){
        
        self.tabBar.tintColor = [UIColor redColor];
        
        UITabBarItem *buyItem = [[UITabBarItem alloc] init];
        [buyItem setTitle:@"求购"];
        [buyItem setImage:[[UIImage imageNamed:@"want2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        UITabBarItem *sellItem = [[UITabBarItem alloc] init];
        [sellItem setTitle:@"供货"];
        [sellItem setImage:[[UIImage imageNamed:@"supply1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        UITabBarItem *mineItem = [[UITabBarItem alloc] init];
        [mineItem setTitle:@"我的"];
        [mineItem setImage:[[UIImage imageNamed:@"mine1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];

        
        
        BuyViewController *buyVC = [[BuyViewController alloc] init];
        buyVC.tabBarItem = buyItem;
        BaseNavigationController *buyNavController = [[BaseNavigationController alloc] initWithRootViewController:buyVC];
        
        SellViewController *sellVC = [[SellViewController alloc] init];
        sellVC.tabBarItem = sellItem;
        BaseNavigationController *sellNavController = [[BaseNavigationController alloc] initWithRootViewController:sellVC];
        
        MineViewController *mineVC = [[MineViewController alloc] init];
        mineVC.tabBarItem = mineItem;
        BaseNavigationController *mineNavController = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
        
        
        self.viewControllers = [NSArray arrayWithObjects:sellNavController, buyNavController, mineNavController, nil];
        
        self.delegate = self;
    }
    
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tabBarHeight = 49;
    self.tabBar.frame = CGRectMake(0, height - tabBarHeight, width, tabBarHeight);
    self.tabBar.clipsToBounds = YES;
//    UIView *transitionView = [[self.view subviews] objectAtIndex:0];
//    transitionView.height = height-tabBarHeight;
}



@end
