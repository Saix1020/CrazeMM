//
//  ToBePaidViewController.m
//  CrazeMM
//
//  Created by saix on 16/8/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "ToBePaidViewController.h"
#import "PayViewController.h"

@implementation ToBePaidViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)initBottomView
{
    self.bottomView.hidden = NO;
}

-(NSString*)titleString
{
    return @"请您尽快付款";
}

-(NSString*)titleDetailString
{
    return [NSString stringWithFormat:@"距离超时还剩: %@", [NSString leftTimeString2:self.leftSeconds*1000]];
}

-(NSString*)bottomButtonString
{
    return @"付款";
}

-(void)handleClickEvent:(UIButton*)button
{
    [self.navigationController pushViewController:[[PayViewController alloc] initWithOrderStatusDTO:self.orderStatusDto] animated:YES];

}

@end
