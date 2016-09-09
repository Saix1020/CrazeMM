//
//  ToBeSendViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ToBeSentViewController.h"
#import "OrderSendViewController.h"
#import "NewOrderListViewController.h"

@implementation ToBeSentViewController

-(void)initBottomView
{
    if (self.style.orderType == kOrderTypeSupply){
        self.bottomView.hidden = NO;
    }
    else {
        self.bottomView.hidden = YES;
    }
}

-(NSString*)titleString
{
    if (self.style.orderType == kOrderTypeSupply) {
        return  @"请您尽快发货";
    }
    else {
        return @"请您等待卖家发货";
    }
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"已支付 %@", [NSString leftTimeString2:self.elapseSeconds*1000]];
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"发货"];
}

-(void)handleClickEvent:(UIButton *)button
{
    OrderSendViewController* sendVC = [[OrderSendViewController alloc] initWithOrderDetaildtos:@[self.orderDto]];
//    NSArray* vcs = self.navigationController.viewControllers;
//    if (vcs.count < 3) {
//        return;
//    }
//    NewOrderListViewController* orderListVC = vcs[vcs.count-2];
//    if (![orderListVC isKindOfClass:[NewOrderListViewController class]]) {
//        return;
//    }
//    sendVC.delegate = orderListVC;
    [self.navigationController pushViewController:sendVC animated:YES];

}

@end
