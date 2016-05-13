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


@interface OrderListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CustomSegmentDelegate, BEMCheckBoxDelegate>

-(instancetype)initWithOrderType:(MMOrderType)orderType andSubType:(MMOrderSubType)subType;


@end
