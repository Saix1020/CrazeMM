//
//  GoodBrandDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "GoodDTO.h"

@implementation GoodBrandDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.name = dict[@"name"];
    }
    return self;
}

@end

@implementation GoodInfoDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.volume = dict[@"volume"];
        self.color = dict[@"color"];
        self.network = dict[@"network"];
        self.model = dict[@"model"];
    }
    return self;
}

@end