//
//  SecondProductDetailCell.h
//  CrazeMM
//
//  Created by saix on 16/4/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailDTO.h"

@interface SecondProductDetailCell : UITableViewCell

@property (nonatomic) NSUInteger productNumber;
@property (nonatomic) CGFloat height;
@property (nonatomic, readonly) float totalPrice;
@property (nonatomic, copy) NSArray<OrderDetailDTO*>* orderDetailDtos;

//-(instancetype)initWithOrderDetailDTO:(OrderDetailDTO*)orderDetailDto;

@end
