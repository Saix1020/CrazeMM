//
//  CompleteViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CompleteViewController.h"

@implementation CompleteViewController

-(void)initBottomView
{
    self.bottomView.hidden = NO;
}

-(NSString*)titleString
{
    return @"已完成";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"已完成 %@", [NSString leftTimeString2:self.elapseSeconds*1000]];
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"删除订单"];
}

-(void)handleClickEvent:(UIButton*)button
{
    //HttpOrderLogicDelete
    NSString* message = [NSString stringWithFormat:@"确认删除订单%ld吗?", self.orderDto.id];
    HttpOrderLogicDelete* request = [[HttpOrderLogicDelete alloc] initWithOid:self.orderStatusDto.id];
    [self invokeHttpRequest:request andConfirmTitle:message andSuccessTitle:@"删除成功"];

}

@end
