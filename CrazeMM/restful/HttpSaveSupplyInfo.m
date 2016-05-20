//
//  HttpSaveSupplyInfo.m
//  CrazeMM
//
//  Created by saix on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSaveSupplyInfo.h"

@implementation GoodCreateInfo


@end

@implementation HttpSaveSupplyInfoRequest

-(instancetype)initWithGoodInfo:(GoodCreateInfo*)goodCreateInfo
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"gbrand" : @(goodCreateInfo.brand),
                         @"supply.gid" : @(goodCreateInfo.id),
                         @"supply.gcolor" : goodCreateInfo.color,
                         @"supply.gvolume": goodCreateInfo.volume,
                         @"supply.quantity":@(goodCreateInfo.quantity),
                         @"supply.gnetwork": goodCreateInfo.network,
                         @"supply.isSerial" : @(goodCreateInfo.isSerial),
                         @"supply.isOriginal" : @(goodCreateInfo.isOriginal),
                         @"supply.isOriginalBox" : @(goodCreateInfo.isOriginalBox),
                         @"supply.price" : @(goodCreateInfo.price),
                         @"supply.deadline" : @(goodCreateInfo.deadline),
                         @"supply.duration" : @(goodCreateInfo.duration),
                         @"supply.isBrushMachine" : @(goodCreateInfo.isBrushMachine),
                         @"supply.isSplit" : @(goodCreateInfo.isSplit),
                         @"supply.isAnoy" : @(goodCreateInfo.isAnoy)
                         } mutableCopy];
    }
    
    return self;
}

-(BOOL)needToken
{
    return YES;
}

-(NSString*)tokenName
{
    return @"save_supply_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/supply");
}

-(NSString*)method
{
    return @"POST";
}

@end
