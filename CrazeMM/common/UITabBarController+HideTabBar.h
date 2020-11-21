//
//  UITabBarController+HideTabBar.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (HideTabBar)

@property (nonatomic, getter=isTabBarHidden) BOOL tabBarHidden;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
