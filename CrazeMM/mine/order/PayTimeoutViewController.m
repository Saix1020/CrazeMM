//
//  PayTimeoutViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayTimeoutViewController.h"
#import "HttpOrderRemove.h"
#import "HttpOrderOperation.h"

@implementation PayTimeoutViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)initBottomView
{

    self.bottomView.hidden = !self.isStyleBuy;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.headCell setTitleLabelColor:[UIColor redColor]];
}

-(NSString*)titleString
{
    
    return @"付款已超时";
}

-(NSString*)titleDetailString
{
    return @"";
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"删除订单", @"重新激活"];
}

-(void)handleClickEvent:(UIButton*)button
{
    
    if([self.bottomButtons indexOfObject:button] == 0){
        [self invokeHttpRequest:[[HttpOrderRemoveRequest alloc] initWithOrderIds:@[@(self.orderDto.id)]]
                andConfirmTitle:[NSString stringWithFormat:@"确定要删除%ld吗?", self.orderDto.id]
                andSuccessTitle:@"删除成功"];
    }
    else {
        [self invokeHttpRequest:[[HttpOrderReactiveRequest alloc] initWithOids:@[@(self.orderDto.id)]]
                andConfirmTitle:[NSString stringWithFormat:@"确定要激活%ld吗?", self.orderDto.id]
                andSuccessTitle:@"删除成功"];
    }
}

@end
