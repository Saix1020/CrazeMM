//
//  MineStockViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonOrderListViewController.h"
#import "SupplyListCell.h"
#import "MineBuyEditViewController.h"
#import "MineStockSellViewController.h"

@interface MineStockViewController : CommonOrderListViewController <SupplyListCellDelegate, MineEditViewControllerDelegate, MineStockSellViewControllerDelegate>


@end
