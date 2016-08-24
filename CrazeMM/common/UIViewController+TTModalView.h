//
//  UIViewController+TTModalView.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (TTModalView)

-(void)showAlertView;

//-(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message andDetail:(NSString*)detail;
-(void)showAlertViewWithMessage:(NSString*)message;
+(void)showAlertViewWithViewController:(UIViewController*)vc;
-(void)showAlertViewWithMessage:(NSString*)message withCallback:(void(^)(id x))callback;
-(void)showAlertViewWithMessage:(NSString*)message withOKCallback:(void(^)(id x))okCallback andCancelCallback:(void(^)(id x))cancelCallback;
@end
