//
//  UIViewController+TTModalView.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIViewController+TTModalView.h"
#import "TTModalView.h"
#import "MMAlertView.h"
#import "MMAlertViewWithOK.h"


@implementation UIViewController (TTModalView)

-(void)showAlertView
{
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.isCancelAble = YES;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    
    MMAlertView *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"MMAlertView" owner:nil options:nil] firstObject];
    transferAlertView.layer.cornerRadius = 6.f;
    
    confirmModalView.contentView = transferAlertView;
    
    confirmModalView.presentAnimationStyle = zoomIn;
    confirmModalView.dismissAnimationStyle = zoomOut ;
    
    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
        
        contentView.centerX = self.view.centerX;
        contentView.centerY = self.view.centerY;
        
        
        transferAlertView.cancel.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            [confirmModalView dismiss];
            return [RACSignal empty];
        }];
    }];
}

-(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message andDetail:(NSString*)detail
{
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.isCancelAble = YES;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    
    MMAlertView *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"MMAlertView" owner:nil options:nil] firstObject];
    transferAlertView.layer.cornerRadius = 6.f;
    
    transferAlertView.title.text = title;
    transferAlertView.message.text = message;
    transferAlertView.detail.text = detail;
    confirmModalView.contentView = transferAlertView;
    
    confirmModalView.presentAnimationStyle = zoomIn;
    confirmModalView.dismissAnimationStyle = zoomOut ;
    
    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
        
        contentView.centerX = self.view.centerX;
        contentView.centerY = self.view.centerY;
        
        
        transferAlertView.cancel.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            [confirmModalView dismiss];
            return [RACSignal empty];
        }];
    }];
}

-(void)showAlertViewWithMessage:(NSString*)message
{
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.isCancelAble = YES;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    
    MMAlertViewWithOK *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"MMAlertViewWithOK" owner:nil options:nil] lastObject];
    transferAlertView.layer.cornerRadius = 6.f;
    
    transferAlertView.alertMsgLabel.text = message;
    confirmModalView.contentView = transferAlertView;
    
    confirmModalView.presentAnimationStyle = zoomIn;
    confirmModalView.dismissAnimationStyle = zoomOut ;
    
    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
        
        contentView.centerX = self.view.centerX;
        contentView.centerY = self.view.centerY;
        
        
        transferAlertView.comfirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            [confirmModalView dismiss];
            return [RACSignal empty];
        }];
    }];
}


@end
