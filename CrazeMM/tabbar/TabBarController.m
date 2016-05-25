//
//  TabBarController.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "TabBarController.h"
#import "BaseNavigationController.h"
#import "MineNoLoginViewController.h"
#import "MineWrapViewController.h"

@interface TabBarController ()

@property (nonatomic, strong) UITabBarItem* prevBarItem;

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
        self.prevBarItem = sellItem;

        
        UITabBarItem *mineItem = [[UITabBarItem alloc] init];
        [mineItem setTitle:@"我的"];
        [mineItem setImage:[[UIImage imageNamed:@"mine1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];

        
        
        self.buyListVC = [[BuyListViewController alloc] init];
        self.buyListVC.tabBarItem = buyItem;
        BaseNavigationController *buyNavController = [[BaseNavigationController alloc] initWithRootViewController:self.buyListVC];
        
        self.supplyListVC = [[SupplyListViewController alloc] init];
        self.supplyListVC.tabBarItem = sellItem;
        BaseNavigationController *sellNavController = [[BaseNavigationController alloc] initWithRootViewController:self.supplyListVC];
        
        self.mineVC = [[MineViewController alloc] init];
        self.mineVC.tabBarItem = mineItem;
        BaseNavigationController* mineNavController = [[BaseNavigationController alloc] initWithRootViewController:self.mineVC];
        
        
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


-(void)loginSuccessed:(id)notifiction
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginSuccessBroadCast object:self];
    UITabBarItem *mineItem = [[UITabBarItem alloc] init];
    [mineItem setTitle:@"我的"];
    [mineItem setImage:[[UIImage imageNamed:@"mine1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];

    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.tabBarItem = mineItem;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (self.prevBarItem == item) {
        return;
    }
    
    if (item == self.supplyListVC.tabBarItem) {
        if (self.supplyListVC.navigationController.viewControllers.count == 1){
            [self.supplyListVC refreshData];
        }
        else {
            [self.supplyListVC refreshDataNoHud];
        }
    }
    else if(item == self.buyListVC.tabBarItem) {
        if (self.buyListVC.navigationController.viewControllers.count == 1){
            [self.buyListVC refreshData];
        }
        else {
            [self.buyListVC refreshDataNoHud];
            
        }

    }
    self.prevBarItem = item;
}
@end
