//
//  PayTimeoutViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayTimeoutViewController.h"
#import "HttpOrderRemove.h"

@implementation PayTimeoutViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)initBottomView
{
    self.bottomView.hidden = NO;
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
        HttpOrderRemoveRequest* request = [[HttpOrderRemoveRequest alloc] initWithOrderIds:@[@(self.orderDto.id)]];
        NSString* message = [NSString stringWithFormat:@"确定要删除%ld吗?", self.orderDto.id];
        [self invokeHttpRequest:request andConfirmTitle:message andSuccessTitle:@"删除成功"];
    }
}

@end
