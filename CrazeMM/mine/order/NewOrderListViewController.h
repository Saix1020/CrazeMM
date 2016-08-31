//
//  NewOrderListViewController.h
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonOrderListViewController.h"
#import "OrderListFilterViewController.h"
#import "OrderDefine.h"
#import "OrderDetailViewController.h"

@interface NewOrderListViewController : CommonOrderListViewController<OrderListFilterViewControllerDelegate, OrderDetailViewControllerDelegate>

//@property (nonatomic, copy) NSDictionary* searchConditions;
@property (nonatomic, readonly) MMOrderListStyle orderListStyle;
@property (nonatomic, readonly) NSDictionary* searchConditions;

@property (nonatomic, readonly) NSArray* operatorDtoIds;


-(void)invokeHttpRequest:(BaseHttpRequest*)httpRequest andConfirmTitle:(NSString *)confirmTitle andSuccessTitle:(NSString *)successTitle;

@end
