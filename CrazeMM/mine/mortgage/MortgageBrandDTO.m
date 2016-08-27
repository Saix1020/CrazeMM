//
//  MortgageBrandDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/7/3.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageBrandDTO.h"

@implementation MortgageBrandDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.name = dict[@"name"];
    }
    return self;
}

@end
