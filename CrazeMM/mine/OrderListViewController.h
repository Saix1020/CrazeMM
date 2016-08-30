//
//  MineSellProductViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"
#import "BEMCheckBox.h"
#import "OrderDefine.h"
#import "OrderListCell.h"
#import "OrderDetailViewController.h"
#import "OrderSendViewController.h"
#import "OrderListFilterViewController.h"


@interface OrderListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CustomSegmentDelegate, BEMCheckBoxDelegate, OrderDetailViewControllerDelegate, OrderListCellDelegate, OrderSendViewControllerDelegate, OrderListFilterViewControllerDelegate>

-(instancetype)initWithOrderType:(MMOrderType)orderType andSubType:(MMOrderSubType)subType;
-(void)removeOrderDtoByOderIds:(NSArray*)ids;

@end
