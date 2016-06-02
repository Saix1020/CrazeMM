//
//  MineStockSellViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"
#import "StockSellCell.h"

@protocol MineStockSellViewControllerDelegate <NSObject>

-(void)sendStockSellSuccess;

@end

@interface MineStockSellViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, StockSellCellDelegate>

@property (nonatomic, weak) id<MineStockSellViewControllerDelegate> delegate;
-(instancetype)initWith:(NSArray*)stocks;

@end
