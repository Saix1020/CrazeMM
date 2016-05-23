//
//  MineSellProductViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"
#import "BEMCheckBox.h"
#import "OrderDefine.h"
#import "OrderListCell.h"
#import "OrderDetailViewController.h"
#import "OrderSendViewController.h"


@interface OrderListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CustomSegmentDelegate, BEMCheckBoxDelegate, OrderDetailViewControllerDelegate, OrderListCellDelegate, OrderSendViewControllerDelegate>

-(instancetype)initWithOrderType:(MMOrderType)orderType andSubType:(MMOrderSubType)subType;


@end
