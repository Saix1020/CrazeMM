//
//  ToBePaidViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ToBePaidViewController.h"
#import "PayViewController.h"
#import "HttpOrderCancel.h"

@implementation ToBePaidViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)initBottomView
{
    if(self.style.orderType == kOrderTypeSupply){
        self.bottomView.hidden = YES;

    }
    else {
        self.bottomView.hidden = NO;
    }
}

-(NSString*)titleString
{
    if(self.style.orderType == kOrderTypeSupply){
        return @"请您等待买家付款";
    }
    else {
        return @"请您尽快付款";
    }
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"距离超时还剩: %@", [NSString leftTimeString2:self.leftSeconds*1000]];
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"付款", @"撤销"];
}

-(void)handleClickEvent:(UIButton*)button
{
    if ([self.bottomButtons indexOfObject:button] == 0) { //@"付款"
        [self.navigationController pushViewController:[[PayViewController alloc] initWithOrderStatusDTO:self.orderStatusDto] animated:YES];

    }
    else { //@"撤销"
        NSString* message = [NSString stringWithFormat:@"确认撤销订单%ld吗?", self.orderDto.id];
        HttpOrderCancelRequest* request = [[HttpOrderCancelRequest alloc] initWithOderId:self.orderStatusDto.id];
        [self invokeHttpRequest:request andConfirmTitle:message andSuccessTitle:@"撤销成功"];
    }

}

@end
