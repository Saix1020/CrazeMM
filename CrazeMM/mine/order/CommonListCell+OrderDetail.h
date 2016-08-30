//
//  CommonListCell+OrderDetail.h
//  CrazeMM
//
//  Created by saix on 16/8/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "CommonListCell.h"
#import "OrderDetailDTO.h"

@interface CommonListCell (OrderDetail)
@property (nonatomic, readonly) OrderDetailDTO* orderDetailDTO;

@end
