//
//  SupplyAllListViewController.m
//  CrazeMM
//
//  Created by saix on 16/9/2.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyAllListViewController.h"

@implementation SupplyAllListViewController

-(MMOrderListStyle)orderListStyle
{
    MMOrderListStyle style = {
        .orderType = kOrderTypeSupply,
        .orderSubType = kOrderSubTypeAll,
        .orderState = TOBEPAID
    };
    
    return style;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的所有卖货";
}

-(HttpListQueryRequest*)makeListQueryRequest
{
    return [[HttpAllSupplyOrderRequest alloc]  initWithPage:self.pageNumber+1 andConditions:self.searchConditions];
}

@end
