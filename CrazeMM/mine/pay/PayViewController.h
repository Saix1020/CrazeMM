//
//  MinePayViewController.h
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"
#import "OrderStatusDTO.h"
#import "BaseProductDetailDTO.h"
#import "AddressListViewController.h"
#import "AddressesViewController.h"
#import "SuggestViewController.h"


@interface PayViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, AddressesViewControllerDelegate, SuggestVCDelegate>

-(instancetype)initWithOrderStatusDTO:(OrderStatusDTO*)orderStatusDto;
-(instancetype)initWithOrderDetailDTOs:(NSArray<OrderDetailDTO*>*)orderStatusDtos;

-(instancetype)initWithProductDto:(BaseProductDetailDTO*)productDto andProductAmount:(NSInteger)amount;

@end
