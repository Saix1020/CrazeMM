//
//  GoodBrandDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/19.
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
        if(!self.volume){
            self.volume = dict[@"volumeList"];
        }
        
        self.color = dict[@"color"];
        if(!self.color){
            self.color = dict[@"colorList"];
        }
        
        self.network = dict[@"network"];
        if(!self.network){
            self.network = dict[@"networkList"];
        }
        
        self.model = dict[@"model"];
        
        NSDictionary* brand = dict[@"brand"];
        if (brand) {
            self.brandName = brand[@"name"];
            self.brandId = [brand[@"id"] integerValue];
        }
    }
    return self;
}

@end