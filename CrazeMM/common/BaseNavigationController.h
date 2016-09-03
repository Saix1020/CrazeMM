//
//  BaseNavigationController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@property (nonatomic, strong) UIViewController* nextViewController;
@property (nonatomic, copy) NSString* confirmString;
@property (nonatomic, weak) UIViewController* markedVC;

- (nullable NSArray<__kindof UIViewController *> *)popToMarkedViewControllerAnimated:(BOOL)animated;

@end
