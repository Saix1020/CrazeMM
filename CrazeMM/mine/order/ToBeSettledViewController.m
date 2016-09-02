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
    return @"待结款";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"最后操作时间 %@", self.orderDto.updateTime];
}

@end
