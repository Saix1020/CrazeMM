//
//  ODClosedViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/2.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ODClosedViewController.h"

@interface ODClosedViewController ()

@end

@implementation ODClosedViewController

-(void)initBottomView
{
    self.bottomView.hidden = YES;
}

-(NSString*)titleString
{
    return @"已关闭";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"最后操作时间 %@", self.orderDto.updateTime];
}

@end
