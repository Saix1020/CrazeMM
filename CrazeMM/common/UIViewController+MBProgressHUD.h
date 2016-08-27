//
//  UIViewController+MBProgressHUD.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (MBProgressHUD)


- (void)showProgressIndicator;
- (void)showProgressIndicatorWithTitle:(NSString*)title;

- (void)dismissProgressIndicator;
@end
