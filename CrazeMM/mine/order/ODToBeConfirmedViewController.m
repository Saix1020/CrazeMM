//
//  ODToBeConfirmedViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ODToBeConfirmedViewController.h"
#import "HttpOrderOperation.h"

@implementation ODToBeConfirmedViewController

-(void)initBottomView
{
    self.bottomView.hidden = YES;
}

-(NSString*)titleString
{
    return @"请您尽快确认";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"已结款%ld", self.elapseSeconds*1000];
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"确认订单"];
}

-(void)handleClickEvent:(UIButton *)button
{
    HttpOrderConfirmRequest* request = [[HttpOrderConfirmRequest alloc] initWithOids:@[@(self.orderDto.id)]];
    [self invokeHttpRequest:request andConfirmTitle:@"确定要确认该订单吗?" andSuccessTitle:@"操作成功"];
}

@end
