//
//  MineSupplyProductDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineSupplyProductDTO.h"

@implementation MineSupplyProductDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.state = [dict[@"state"] integerValue];
    }
    return self;
}

@end
