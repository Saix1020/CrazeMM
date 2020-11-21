//
//  ODPayBackViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ODPayBackViewController.h"

@implementation ODPayBackViewController

-(void)initBottomView
{
    self.bottomView.hidden = YES;
}

-(NSString*)titleString
{
    return @"待退款";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"最后操作时间 %@", self.orderDto.updateTime];
}


@end
