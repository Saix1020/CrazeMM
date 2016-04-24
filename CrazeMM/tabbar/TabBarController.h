//
//  TabBarController.h
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

@interface TabBarController : UITabBarController <UITabBarControllerDelegate, UITabBarDelegate>

@property (nonatomic, weak) id            tabBarDelegate;


- (BOOL)checkUserLoginOrNot;
- (void)showBadgeValue:(NSString*)number;


@end