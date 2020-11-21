//
//  ToBeSettledViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ToBeSettledViewController.h"

@implementation ToBeSettledViewController

-(void)initBottomView
{
    self.bottomView.hidden = YES;
}

-(NSString*)titleString
{
    if (self.isStyleBuy) {
        return @"已完成";
    }
    else {
        return @"请您等待网站结款";
    }
}

-(NSString*)titleDetailString
{
    if (self.isStyleBuy) {
        return [NSString stringWithFormat:@"已完成%ld", self.elapseSeconds*1000];

    }
    else {
        return  [NSString stringWithFormat:@"已签收%ld", self.elapseSeconds*1000];
    }
}

@end
