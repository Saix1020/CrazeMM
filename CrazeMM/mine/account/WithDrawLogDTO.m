//
//  WithDrawLogDTO.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "WithDrawLogDTO.h"

@implementation WithDrawLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    
    if (self) {
        self.amount = [dict[@"amount"] floatValue];
        self.uid = [dict[@"uid"] integerValue];
        self.state = [dict[@"state"] integerValue];
        self.bid = [dict[@"bid"] integerValue];
        
        self.bankaccount = dict[@"bankaccount"];
        self.bankusername = dict[@"bankusername"];
        self.createTime = dict[@"createTime"];
        self.stateLabel = dict[@"stateLabel"];
        self.comment = dict[@"comment"];
        self.applyTime = dict[@"applyTime"];
        self.openingbank = dict[@"openingbank"];


    }
    return self;
}

@end
