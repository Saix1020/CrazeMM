//
//  BalanceDTO.m
//  CrazeMM
//
//  Created by saix on 16/6/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BalanceDTO.h"

@implementation BalanceDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.uid = [dict[@"uid"] integerValue];
        self.money = [dict[@"money"] floatValue];
        self.freezeMoney = [dict[@"freezeMoney"] floatValue];
    }
    
    return self;
}

-(NSString*)smoney
{
    return [NSString stringWithFormat:@"%.02f", self.money];
}

-(NSString*)sfreezeMoney
{
    return [NSString stringWithFormat:@"%.02f", self.freezeMoney];
}

@end

@implementation BalanceLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    
    if (self) {
        self.build = [dict[@"build"] integerValue];
        self.balanceOrderId = [dict[@"balanceOrderId"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
        self.state = [dict[@"state"] integerValue];
        
        self.afterMoney = [dict[@"afterMoney"] floatValue];
        self.beforeMoney = [dict[@"beforeMoney"] floatValue];
        self.afterFreezeMoney = [dict[@"afterFreezeMoney"] floatValue];
        self.beforeFreezeMoney = [dict[@"beforeFreezeMoney"] floatValue];
        self.amountOfMoney = [dict[@"amountOfMoney"] floatValue];
        
        self.message = dict[@"message"];
        self.type = dict[@"type"];
        self.createTime = dict[@"createTime"];

    }
    return self;
    
}

-(NSString*)description
{
    return [NSString stringWithFormat:
            @"【金额：%.0f】 %@\n"
            @"可用金额：%.02f, 冻结金额：%.02f\n"
            @"%@",
            self.amountOfMoney, self.createTime,
            self.afterMoney, self.afterFreezeMoney,
            self.message];
}

@end
