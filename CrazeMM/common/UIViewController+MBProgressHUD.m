//
//  UIViewController+MBProgressHUD.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIViewController+MBProgressHUD.h"

@implementation UIViewController (MBProgressHUD)

- (void)showProgressIndicator
{
    MBProgressHUD* progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progressHud];
    [self.view bringSubviewToFront:progressHud];
    [progressHud show:YES];
}

- (void)showProgressIndicatorWithTitle:(NSString*)title
{
    MBProgressHUD* progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:progressHud];
    [self.view bringSubviewToFront:progressHud];
    progressHud.labelText = title;
    [progressHud show:YES];
}

- (void)dismissProgressIndicator
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
