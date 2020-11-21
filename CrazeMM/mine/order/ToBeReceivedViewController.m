//
//  ToBeReceivedViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ToBeReceivedViewController.h"
#import "HttpOrderOperation.h"


@implementation ToBeReceivedViewController

-(void)initBottomView
{
    if (self.style.orderType == kOrderTypeSupply) {
        self.bottomView.hidden = YES;
    }
    else {
        self.bottomView.hidden = NO;
    }
}

-(NSString*)titleString
{
    if (self.style.orderType == kOrderTypeSupply) {
        return @"请您等待买家签收";
    }
    else {
        return @"请您尽快签收";
    }
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"已发货 %@", [NSString leftTimeString2:self.elapseSeconds*1000]];
}

-(NSArray*)bottomButtonsTitle
{
    return @[@"签收"];
}


-(void)handleClickEvent:(UIButton*)button
{
    if ([self.bottomButtons indexOfObject:button] == 0) { //@"签收"
        [self invokeHttpRequest:[[HttpOrderReceiveRequest alloc] initWithOids:@[@(self.orderDto.id)]]
                andConfirmTitle:[NSString stringWithFormat:@"确定要签收%ld吗?", self.orderDto.id]
                andSuccessTitle:@"操作成功"];

        
    }
}

@end
