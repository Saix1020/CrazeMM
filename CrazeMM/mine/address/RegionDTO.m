//
//  RegionDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "RegionDTO.h"
#import "HttpAllRegion.h"

@implementation RegionDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.name = dict[@"name"];
        self.cities = [[NSMutableArray alloc] init];
        for (NSDictionary* xdict in dict[@"child"]) {
            [self.cities addObject:[[CityDTO alloc] initWith:xdict]];
        }

    }
    return self;
}

@end

@implementation AreaDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.name = dict[@"name"];
    }
    
    return self;
}

@end

@implementation CityDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.name = dict[@"name"];
        self.areas = [[NSMutableArray alloc] init];
        for (NSDictionary* xdict in dict[@"child"]) {
            [self.areas addObject:[[AreaDTO alloc] initWith:xdict]];
        }
    }
    
    return self;
}

@end