//
//  UIViewController+Utils.h
//  CrazeMM
//
//  Created by saix on 16/9/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpRequest.h"
typedef void (^InvokeHttpRequestCallback)(BaseHttpRequest*, NSString*);

@interface UIViewController (Utils)
-(void)invokeHttpRequest:(BaseHttpRequest*)httpRequest
         andConfirmTitle:(NSString*)confirmTitle
         andSuccessTitle:(NSString*)successTitle
      andSuccessCallback:(InvokeHttpRequestCallback)successCallback
       andFailedCallback:(InvokeHttpRequestCallback)failedCallback;

-(void)invokeHttpRequest:(BaseHttpRequest*)httpRequest
         andConfirmTitle:(NSString*)confirmTitle
         andSuccessTitle:(NSString*)successTitle;

-(void)httpRequestSuccess:(BaseHttpRequest*)request andSuccessMsg:(NSString*)msg;
-(void)httpRequestFailed:(BaseHttpRequest*)request andFailedMsg:(NSString*)msg;


//-(void)setMarkedVCForNavigationVC:(UIViewController*)markedVC;
@property (nonatomic, strong) UIViewController* markedVC;



@end
