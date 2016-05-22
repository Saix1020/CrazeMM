//
//  BankCardDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BankCardDTO.h"

@implementation BankCardDTO

-(instancetype) initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.bankaccount = dict[@"bankaccount"];
        self.bankusername = dict[@"bankusername"];
        self.isDefault = [dict[@"isDefault"] boolValue];
        self.openingbank = dict[@"openingbank"];
        self.state = [dict[@"state"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
    }
    return self;
}

@end
