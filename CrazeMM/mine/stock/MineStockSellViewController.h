//
//  MineStockSellViewController.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

@interface MineStockSellViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, BEMCheckBoxDelegate>

-(instancetype)initWith:(NSArray*)stocks;

@end
