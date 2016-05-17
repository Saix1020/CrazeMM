//
//  HttpMineSupplyUnshelve.m
//  CrazeMM
//
//  Created by saix on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMineSupplyUnshelve.h"

@implementation HttpMineSupplyUnshelveRequest

-(instancetype)initWithIds:(NSArray*)ids
{
    self = [super init];
    if (self) {
        self.params = [@{@"id" : [ids componentsJoinedByString:@","]} mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/supply/unshelve");
}

-(NSString*)method
{
    return @"GET";
}

@end
