//
//  DepotDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "DepotDTO.h"

@implementation DepotDTO


-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.name = dict[@"name"];
        self.info = dict[@"info"];
    }
    return self;
}

@end