//
//  UIViewController+TTModalView.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (TTModalView)

-(void)showAlertView;

-(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message andDetail:(NSString*)detail;
-(void)showAlertViewWithMessage:(NSString*)message;

@end
