//
//  UIViewController+Utils.m
//  CrazeMM
//
//  Created by saix on 16/9/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "BaseNavigationController.h"


@implementation UIViewController (Utils)

#pragma - mark Async http request handle
-(void)invokeHttpRequest:(BaseHttpRequest*)httpRequest
         andConfirmTitle:(NSString*)confirmTitle
         andSuccessTitle:(NSString*)successTitle
      andSuccessCallback:(InvokeHttpRequestCallback)successCallback
       andFailedCallback:(InvokeHttpRequestCallback)failedCallback
{
    @weakify(self);
    [self showAlertViewWithMessage:confirmTitle
                    withOKCallback:^(id x){
                        @strongify(self);
                        [self showProgressIndicatorWithTitle:@"正在处理..."];
                        
                        [httpRequest request]
                        .then(^(id responseObj){
                            NSLog(@"%@", responseObj);
                            if (httpRequest.response.ok) {
                                
                                if (successCallback) {
                                    successCallback(httpRequest, successTitle);
                                }
                                else {
                                    [self httpRequestSuccess:httpRequest andSuccessMsg:successTitle];
                                }
                            }
                            else {
                                if(failedCallback) {
                                    failedCallback(httpRequest, httpRequest.response.errorMsg);
                                }
                                else {
                                    [self httpRequestFailed:httpRequest andFailedMsg:httpRequest.response.errorMsg];
                                }
                            }
                        })
                        .catch(^(NSError* error){
                            [self showAlertViewWithMessage:error.localizedDescription];
                        })
                        .finally(^(){
                            [self dismissProgressIndicator];
                        });
                    }
                 andCancelCallback:nil];
}

-(void)invokeHttpRequest:(BaseHttpRequest*)httpRequest
         andConfirmTitle:(NSString*)confirmTitle
         andSuccessTitle:(NSString*)successTitle
{
    [self invokeHttpRequest:httpRequest
            andConfirmTitle:confirmTitle
            andSuccessTitle:successTitle
         andSuccessCallback:nil
          andFailedCallback:nil];
}

-(void)httpRequestSuccess:(BaseHttpRequest*)request andSuccessMsg:(NSString *)msg
{
    [self showAlertViewWithMessage:msg withCallback:^(id x){
        [self.navigationController popViewControllerAnimated:YES];
    }];

}
-(void)httpRequestFailed:(BaseHttpRequest*)request andFailedMsg:(NSString*)msg
{
    [self showAlertViewWithMessage:msg];
}


-(void)setMarkedVC:(UIViewController *)markedVC
{
    if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
        ((BaseNavigationController*)self.navigationController).markedVC = markedVC;
    }
}

-(UIViewController*)markedVC
{
    if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
        return ((BaseNavigationController*)self.navigationController).markedVC;
    }
    
    return nil;
}

@end
