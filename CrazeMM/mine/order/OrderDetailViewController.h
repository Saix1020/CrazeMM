//
//  OrderDetailViewController.h
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"
#import "OrderDefine.h"

@interface OrderDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

-(instancetype)initWithOrderStyle:(MMOrderListStyle)style andOrder:(OrderDetailDTO*)orderDto;

@end
