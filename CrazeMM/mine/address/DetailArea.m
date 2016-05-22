//
//  DetailArea.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/20.
//  Copyright © 2016年 189. All rights reserved.
//

#import "DetailArea.h"

@implementation DetailArea

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _ID       = dict[@"id"];
        _areaName = dict[@"areaName"];
    }
    return self;
}

+ (instancetype)detailAreaWithDict:(NSDictionary *)dict {
    return [[DetailArea alloc] initWithDict:dict];
}


@end
