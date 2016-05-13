//
//  AddrDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddrDTO.h"

@implementation AddrDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.uid = [dict[@"uid"] integerValue];
        self.pid = [dict[@"pid"] integerValue];
        self.did = [dict[@"did"] integerValue];
        self.cid = [dict[@"cid"] integerValue];
        self.isDefault = [dict[@"isDefault"] boolValue];
        self.zipCode = dict[@"zipCode"];
        self.phone = dict[@"phone"];
        self.street = dict[@"street"];
        self.contact = dict[@"contact"];
        self.mobile = dict[@"mobile"];
        self.region = dict[@"region"];

    }
    
    return self;
}

@end
