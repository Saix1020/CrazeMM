//
//  AddressDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "AddressDTO.h"

@implementation AddressDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.street = dict[@"street"];
        self.region = dict[@"region"];
        self.mobile = dict[@"mobile"];
        self.contact = dict[@"contact"];
        //self.zipCode = dict[@"zipCode"];
    }
    
    return self;
}


@end
