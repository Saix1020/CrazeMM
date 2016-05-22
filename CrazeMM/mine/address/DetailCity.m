//
//  DetailCity.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "DetailCity.h"
#import "DetailArea.h"

@implementation DetailCity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID = dict[@"id"];
        _cityName = dict[@"cityName"];
        
        NSArray *areaArray = [NSMutableArray arrayWithArray:dict[@"arealist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in areaArray) {
            DetailArea *city = [DetailArea detailAreaWithDict:dict];
            [newArray addObject:city];
        }
        _arealist = newArray;
        
    }
    return self;
}

+ (instancetype)detailCityWithDict:(NSDictionary *)dict {
    return [[DetailCity alloc] initWithDict:dict];
}


@end
