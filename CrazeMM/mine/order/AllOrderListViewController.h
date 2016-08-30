//
//  AllOrderListViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDefine.h"
#import "OrderListViewController.h"

@interface AllOrderListViewController : OrderListViewController

-(instancetype)initWithOrderType:(MMOrderType)orderType;

@end
