//
//  UIViewController+TTModalView.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIViewController+TTModalView.h"
#import "TTModalView.h"
#import "MMAlertView.h"
#import "MMAlertViewWithOK.h"

#define kUseAlertViewController NO

BOOL isAlertViewShowing;


@implementation UIViewController (TTModalView)

//-(void)showAlertView
//{
//    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
//    confirmModalView.isCancelAble = YES;
//    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
//    
//    MMAlertViewWithOKAndCancel *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"MMAlertView" owner:nil options:nil] firstObject];
//    transferAlertView.layer.cornerRadius = 6.f;
//    
//    confirmModalView.contentView = transferAlertView;
//    
//    confirmModalView.presentAnimationStyle = zoomIn;
//    confirmModalView.dismissAnimationStyle = zoomOut ;
//    
//    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
//        
//        contentView.centerX = self.view.centerX;
//        contentView.centerY = self.view.centerY;
//        
//        
//        transferAlertView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
//            [confirmModalView dismiss];
//            return [RACSignal empty];
//        }];
//    }];
//}
//
//-(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)message andDetail:(NSString*)detail
//{
//    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
//    confirmModalView.isCancelAble = YES;
//    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
//    
//    MMAlertViewWithOKAndCancel *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"MMAlertView" owner:nil options:nil] firstObject];
//    transferAlertView.layer.cornerRadius = 6.f;
//    
////    transferAlertView.title.text = title;
//    transferAlertView.AlertMsgLabel.text = message;
////    transferAlertView.detail.text = detail;
//    confirmModalView.contentView = transferAlertView;
//    
//    confirmModalView.presentAnimationStyle = zoomIn;
//    confirmModalView.dismissAnimationStyle = zoomOut ;
//    
//    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
//        
//        contentView.centerX = self.view.centerX;
//        contentView.centerY = self.view.centerY;
//        
//        
//        transferAlertView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
//            [confirmModalView dismiss];
//            return [RACSignal empty];
//        }];
//    }];
//}



-(void)showAlertViewWithMessage:(NSString*)message
{
    if(kUseAlertViewController){
        [self showAlertViewWithMessageNew:message];
        return;
    }
    
    @synchronized (self) {
        if (isAlertViewShowing) {
            return;
        }
        isAlertViewShowing = YES;
    }
    
    
    
    
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    confirmModalView.isCancelAble = NO;
    
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
            isAlertViewShowing = NO;
            return [RACSignal empty];
        }];
    }];
}

-(void)showAlertViewWithMessage:(NSString*)message withCallback:(void(^)(id x))callback
{
    if(kUseAlertViewController){
        [self showAlertViewWithMessageNew:message withCallback:callback];
        return;
    }
    
    @synchronized (self) {
        if (isAlertViewShowing) {
            return;
        }
        isAlertViewShowing = YES;
    }
    

    
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.isCancelAble = YES;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    confirmModalView.isCancelAble = NO;

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
            isAlertViewShowing = NO;
            [confirmModalView dismiss];
            if (callback) {
                callback(confirmModalView);
            }
            return [RACSignal empty];
        }];
    }];
}

-(void)showAlertViewWithMessage:(NSString*)message withOKCallback:(void(^)(id x))okCallback andCancelCallback:(void(^)(id x))cancelCallback
{
    if(kUseAlertViewController){
        [self showAlertViewWithMessageNew:message withOKCallback:okCallback andCancelCallback:cancelCallback];
        return;
    }
    
    @synchronized (self) {
        if (isAlertViewShowing) {
            return;
        }
        isAlertViewShowing = YES;
    }
    
    
    
    
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.isCancelAble = YES;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    confirmModalView.isCancelAble = NO;

    MMAlertViewWithOKAndCancel *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"MMAlertView" owner:nil options:nil] lastObject];
    transferAlertView.layer.cornerRadius = 6.f;
    
    transferAlertView.AlertMsgLabel.text = message;
    confirmModalView.contentView = transferAlertView;
    
    confirmModalView.presentAnimationStyle = zoomIn;
    confirmModalView.dismissAnimationStyle = zoomOut ;
    
    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
        
        contentView.centerX = self.view.centerX;
        contentView.centerY = self.view.centerY;
        
        
        transferAlertView.confirmButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            isAlertViewShowing = NO;
            [confirmModalView dismiss];
            if (okCallback) {
                okCallback(confirmModalView);
            }
            return [RACSignal empty];
        }];
        transferAlertView.cancelButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal* (id x){
            isAlertViewShowing = NO;
            [confirmModalView dismiss];
            if (cancelCallback) {
                cancelCallback(confirmModalView);
            }
            return [RACSignal empty];
        }];
    }];
}

-(AFPromise*)promiseAlertViewWithMessage:(NSString*)message
{
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        [self showAlertViewWithMessage:message
                        withOKCallback:^(id x){
                            resolver(x);
                        }
                     andCancelCallback:^(id x){
                         NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"alert cancle"                                                                     forKey:NSLocalizedDescriptionKey];
                         NSError* error = [[NSError alloc] initWithDomain:CustomErrorDomain code:-11111 userInfo:userInfo];
                         resolver(error);

                     }];
        
    }];

}


+(void)showAlertViewWithViewController:(UIViewController*)vc
{
    TTModalView *confirmModalView = [[TTModalView alloc] initWithContentView:nil delegate:nil];;
    confirmModalView.isCancelAble = NO;
    confirmModalView.modalWindowLevel = UIWindowLevelNormal;
    
//    MMAlertViewWithOK *transferAlertView = [[[NSBundle mainBundle]loadNibNamed:@"MMAlertViewWithOK" owner:nil options:nil] lastObject];
//    transferAlertView.layer.cornerRadius = 0;
    
//    transferAlertView.alertMsgLabel.text = message;
    confirmModalView.contentView = vc.view;
    
    confirmModalView.presentAnimationStyle = zoomIn;
    confirmModalView.dismissAnimationStyle = zoomOut ;
    
    [confirmModalView showWithDidAddContentBlock:^(UIView *contentView) {
        
//        contentView.centerX = self.view.centerX;
//        contentView.centerY = self.view.centerY;
        contentView.frame = [UIScreen mainScreen].bounds;
        
    }];
}


#pragma - mark new alert view
//-(void)showAlertViewWithMessage:(NSString*)message;
//+(void)showAlertViewWithViewController:(UIViewController*)vc;
//-(void)showAlertViewWithMessage:(NSString*)message withCallback:(void(^)(id x))callback;
//-(void)showAlertViewWithMessage:(NSString*)message withOKCallback:(void(^)(id x))okCallback andCancelCallback:(void(^)(id x))cancelCallback;

-(void)showAlertViewWithMessageNew:(NSString*)message
{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSLog(@"OK");
//    }];
////    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
////        NSLog(@"Cancel");
////    }];
////    
////    UIAlertAction *Destructive = [UIAlertAction actionWithTitle:@"Destructive" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
////        NSLog(@"Destructive");
////    }];
//    
//    [alert addAction:ok];
//    [self presentViewController:alert animated:YES completion:nil];
    [self showAlertViewWithMessageNew:message withCallback:nil];
 
}

-(void)showAlertViewWithMessageNew:(NSString*)message withCallback:(void(^)(id x))callback
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (callback) {
            callback(action);
        }
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)showAlertViewWithMessageNew:(NSString*)message withOKCallback:(void(^)(id x))okCallback andCancelCallback:(void(^)(id x))cancelCallback
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (okCallback) {
            okCallback(action);
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (cancelCallback) {
            cancelCallback(action);
        }
    }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
