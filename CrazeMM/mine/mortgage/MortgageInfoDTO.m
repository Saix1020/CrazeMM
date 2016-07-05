//
//  MortgageInfoDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/7/3.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageInfoDTO.h"

@implementation MortgageInfoDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.duration = [dict[@"duration"] integerValue];
        self.interestRate = [dict[@"interestRate"] floatValue];
        self.price = [dict[@"price"] floatValue];
        self.goodColor = dict[@"goodColor"];
        self.goodNetwork = dict[@"goodNetwork"];
        self.goodVolume = dict[@"goodVolume"];

    }
    return self;
}


@end
