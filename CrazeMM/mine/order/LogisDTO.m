//
//  LogisDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "LogisDTO.h"

@implementation LogisDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.name = dict[@"name"];
        self.querySite = dict[@"querySite"];
    }
    return self;
}

@end
