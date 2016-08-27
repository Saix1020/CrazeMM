//
//  SupplyViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegment.h"
#import "CommonOrderListViewController.h"
#import "SupplyListCell.h"
#import "MineSupplyEditViewController.h"

@interface SupplyViewController : CommonOrderListViewController<SupplyListCellDelegate, MineEditViewControllerDelegate>

@end
