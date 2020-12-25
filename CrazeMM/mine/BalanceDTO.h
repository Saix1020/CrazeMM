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

@interface BalanceLogDTO : BaseDTO

//{"buid":4,"balanceOrderId":0,"afterMoney":747494.00,"message":"账户提现，提现记录ID：10","type":null,"amountOfMoney":1.00,"uid":4,"createTime":"2016-06-12 11:12:49","afterFreezeMoney":6.00,"beforeFreezeMoney":5.00,"id":133,"state":200,"beforeMoney":747495.00},

@property (nonatomic) NSInteger build;
@property (nonatomic) NSInteger balanceOrderId;
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger state;

@property (nonatomic) float afterMoney;
@property (nonatomic) float beforeMoney;
@property (nonatomic) float afterFreezeMoney;
@property (nonatomic) float beforeFreezeMoney;
@property (nonatomic) float amountOfMoney;

@property (nonatomic, copy) NSString* message;
@property (nonatomic, copy) NSString* type;
@property (nonatomic, copy) NSString* createTime;


@end
