//
//  BalanceDTO.h
//  CrazeMM
//
//  Created by saix on 16/6/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface BalanceDTO : BaseDTO

@property (nonatomic) NSInteger uid;
@property (nonatomic) float money;
@property (nonatomic) float freezeMoney;

@property (nonatomic, readonly) NSString* smoney;
@property (nonatomic, readonly) NSString* sfreezeMoney;


@end
