//
//  MineStockDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineStockDTO.h"

@implementation MineStockDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.depotDto = [[DepotDTO alloc] initWith:dict[@"depot"]];
        self.price = [dict[@"inprice"] floatValue];
        self.quantity = [dict[@"presale"] integerValue];
        self.createTime = dict[@"updateTime"];
    }
    return self;
}

@end
