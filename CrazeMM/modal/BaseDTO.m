//
//  BaseDTO.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@implementation BaseDTO

-(instancetype)initWith:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        self.id = [dict[@"id"] integerValue];
    }
    return self;
}
-(NSDictionary *)encode
{
    return nil;
}

-(void)parserResponse
{
    
}

@end


@implementation BaseListDTO

-(float)totalPrice
{
    return 0.f;
}

@end
