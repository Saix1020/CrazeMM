//
//  PayResultViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/26.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockDetailDTO.h"

@interface PayResultViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

-(instancetype)initWithStockDetailDtos:(NSArray*)stockDetailDTOs;

@end
