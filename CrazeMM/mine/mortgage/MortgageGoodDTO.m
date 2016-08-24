//
//  MortgageGoodDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/7/3.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageGoodDTO.h"

@implementation MortgageGoodDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.model = dict[@"model"];
    }
    return self;
}

@end
