//
//  ToBeSendViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ToBeSentViewController.h"

@implementation ToBeSentViewController

-(void)initBottomView
{
    self.bottomView.hidden = YES;
}

-(NSString*)titleString
{
    return @"请您等待卖家发货";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"已支付 %@", [NSString leftTimeString2:self.elapseSeconds*1000]];
}


@end
