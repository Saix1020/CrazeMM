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
#import "HttpOrderOperation.h"
#import "OrderSendViewController.h"


@interface NewOrderListViewController : CommonOrderListViewController<OrderListFilterViewControllerDelegate, OrderDetailViewControllerDelegate, OrderSendViewControllerDelegate>
{
    @protected
    OrderListFilterViewController* _filterVC;
}

//@property (nonatomic, copy) NSDictionary* searchConditions;
@property (nonatomic, readonly) MMOrderListStyle orderListStyle;
@property (nonatomic, readonly) NSDictionary* searchConditions;

@property (nonatomic, readonly) NSArray* operatorDtoIds;
@property (nonatomic, strong) OrderListFilterViewController *filterVC;


-(void)invokeHttpRequest:(BaseHttpRequest*)httpRequest andConfirmTitle:(NSString *)confirmTitle andSuccessTitle:(NSString *)successTitle;

@end
