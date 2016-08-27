//
//  SupplyProductDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/9.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SupplyProductDTO.h"

@implementation SupplyProductDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
    }
    
    return self;
}

-(NSString*)description
{
    NSString* string = [NSString stringWithFormat:@"%@\n%@", self.createTime, self.goodImage];
    return [NSString stringWithFormat:@"%@\n%@", [super description], string];
}

@end
