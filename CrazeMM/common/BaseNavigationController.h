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

@end
