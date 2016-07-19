//
//  OutStockViewController.h
//  CrazeMM
//
//  Created by saix on 16/6/27.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuggestViewController.h"
#import "AddressesViewController.h"
#import "MineStockDTO.h"
#import "ConsigneeListViewController.h"
@interface OutStockViewController : UITableViewController<SuggestVCDelegate, AddressesViewControllerDelegate, ConsigneeListViewControllerDelegate>

-(instancetype)initWithStockDtos:(NSArray*)stockDtos;

@end
