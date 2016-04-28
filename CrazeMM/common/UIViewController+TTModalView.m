//
//  UIViewController+TTModalView.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIViewController+TTModalView.h"
#import "TTModalView.h"
#import "TransferAlertView.h"

@implementation UIViewController (TTModalView)

-(void)showAlertView
{
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.isCancelAble = YES;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    
    TransferAlertView *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"TransferAlertView" owner:nil options:nil] firstObject];
    transferAlertView.layer.cornerRadius = 6.f;
    
    confirmModalView.contentView = transferAlertView;
    
    confirmModalView.presentAnimationStyle = zoomIn;
    confirmModalView.dismissAnimationStyle = zoomOut ;
    
    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
        
        contentView.centerX = self.view.centerX;
        contentView.centerY = self.view.centerY;
        
        
        transferAlertView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            [confirmModalView dismiss];
            return [RACSignal empty];
        }];
    }];
}


@end
