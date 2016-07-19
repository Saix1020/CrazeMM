//
//  SupplyDetailDTO.m
//  CrazeMM
//
//  Created by saix on 16/6/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyDetailDTO.h"

@implementation MineSupplyLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.sid = [dict[@"sid"] integerValue];
    }
    return self;
}

@end


@implementation MineSupplyDetailDTO

-(Class)logClass
{
    return [MineSupplyLogDTO class];
}

@end
