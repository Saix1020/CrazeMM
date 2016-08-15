//
//  MineBuyViewController.h
//  CrazeMM
//
//  Created by saix on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonOrderListViewController.h"
#import "SupplyListCell.h"
#import "MineBuyEditViewController.h"

// we also use SupplyListCell here.

@interface MineBuyViewController : CommonOrderListViewController<SupplyListCellDelegate, MineEditViewControllerDelegate>

@end
