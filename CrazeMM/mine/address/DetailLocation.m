//
//  DetailLocation.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "DetailLocation.h"
#import "DetailCity.h"

@implementation DetailLocation

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID = dict[@"id"];
        _provinceName = dict[@"provinceName"];
        
        NSArray *citiesArray = [NSMutableArray arrayWithArray:dict[@"citylist"]];
        NSMutableArray *newArray = [NSMutableArray array];
        for (NSDictionary *dict in citiesArray) {
            DetailCity *city = [DetailCity detailCityWithDict:dict];
            [newArray addObject:city];
        }
        _citylist = newArray;
        
    }
    return self;
}

+ (instancetype)detailLocationWithDict:(NSDictionary *)dict {
    return [[DetailLocation alloc] initWithDict:dict];
}

@end
