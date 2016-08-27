//
//  SearchResultDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "SearchResultDTO.h"

@implementation SearchResultDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    
    if (self) {
        self.isActive = [dict[@"isActive"] boolValue];
    }
    
    return self;
}

@end
