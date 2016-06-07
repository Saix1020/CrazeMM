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
