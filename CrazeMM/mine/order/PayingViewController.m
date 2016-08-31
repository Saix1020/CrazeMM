//
//  PayingViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayingViewController.h"
#import "HttpPayRecord.h"
#import "OnlinePayViewController.h"

@implementation PayingViewController


-(void)initBottomView
{
    self.bottomView.hidden = NO;
}

-(NSString*)titleString
{
    return @"支付中";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"操作时间: %@", self.orderDto.updateTime];
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"刷新订单", @"设置失败", @"重新支付"];
}


-(void)handleClickEvent:(UIButton *)button
{
    NSString* payNoString = self.orderStatusDto.lastPayNo;
    if(payNoString.length == 0) {
        payNoString = @"P0";
    }
    NSInteger payNo = [payNoString substringFromIndex:1].integerValue;
    @weakify(self);

    if ([self.bottomButtons indexOfObject:button] == 2) { // 重新支付
        [self showAlertViewWithMessage:[NSString stringWithFormat:@"您要重新支付订单%@吗?", payNoString]
                        withOKCallback:^(id x){
                            @strongify(self);
                            [self showProgressIndicatorWithTitle:@"正在处理..."];
                            HttpPayDataRequest* request = [[HttpPayDataRequest alloc] initWithPayNo:payNo];
                            [request request].then(^(id responseObj){
                                NSLog(@"%@",responseObj);
                                if (!request.response.ok) {
                                    [self showAlertViewWithMessage:request.response.errorMsg];
                                }
                                else {
                                    HttpPayDataResponse* response = (HttpPayDataResponse*)request.response;
                                    OnlinePayViewController* vc = [[OnlinePayViewController alloc] initWithPayInfoDto:response.payInfoDto];
                                    [self.navigationController pushViewController:vc animated:YES];
                                }
                                
                            })
                            .catch(^(NSError* error){
                                [self showAlertViewWithMessage:error.localizedDescription];
                            })
                            .finally(^(){
                                [self dismissProgressIndicator];
                            });
                            
                            
                        }
                     andCancelCallback:^(id x){
                         
                     }];

    }
    else if([self.bottomButtons indexOfObject:button] == 0){
        [self invokeHttpRequest:[[HttpPayRefreshRequest alloc] initWithPayNo:payNo]
                andConfirmTitle:[NSString stringWithFormat:@"确定要刷新订单%@吗?", payNoString]
                andSuccessTitle:@"操作成功"];
    }
    else {
        [self invokeHttpRequest:[[HttpPayCancelRequest alloc] initWithPayNo:payNo]
                andConfirmTitle:[NSString stringWithFormat:@"确定要设置订单%@支付失败吗", payNoString]
                andSuccessTitle:@"操作成功"];

    }
}


@end
