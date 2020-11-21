//
//  MineBuyLogDTO.m
//  CrazeMM
//
//  Created by saix on 16/9/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineBuyDetailDTO.h"

@implementation MineBuyLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.bid = [dict[@"bid"] integerValue];
    }
    return self;
}


@end


@implementation MineBuyDetailDTO

-(Class)logClass
{
    return [MineBuyLogDTO class];
}

@end

