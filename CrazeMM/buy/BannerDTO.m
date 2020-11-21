//
//  BannerDTO.m
//  CrazeMM
//
//  Created by saix on 16/10/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BannerDTO.h"

@implementation BannerDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    
    if (self) {
        self.createTime = dict[@"createTime"];
        self.disabled = [dict[@"disabled"] boolValue];
        self.image = dict[@"image"];
        self.location = [dict[@"location"] integerValue];
        self.orderNum = [dict[@"orderNum"] integerValue];
        self.title = dict[@"title"];
        self.bgColor = dict[@"bgColor"];
        self.url = dict[@"url"];
        self.desc = dict[@"desc"];
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self forKey:@"189MM-Banner"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self = [aDecoder decodeObjectForKey:@"189MM-Banner"];
    }
    return self;
}

@end
