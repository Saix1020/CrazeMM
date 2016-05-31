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

@implementation HttpSaveBuyInfoRequest

//save_buy_token:4376351719679073752
//gbrand:28
//buy.gid:1670
//buy.gcolor:黑
//buy.gvolume:16G
//buy.gnetwork:电信版
//buy.isSerial:true
//buy.isOriginal:true
//buy.isOriginalBox:true
//buy.isBrushMachine:true
//buy.price:1000
//buy.quantity:20
//buy.deadline:72
//buy.duration:24
//buy.addrId:178
//buy.isAnoy:true

-(instancetype)initWithGoodInfo:(GoodCreateInfo*)goodCreateInfo
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"gbrand" : @(goodCreateInfo.brand),
                         @"buy.gid" : @(goodCreateInfo.id),
                         @"buy.gcolor" : goodCreateInfo.color,
                         @"buy.gvolume": goodCreateInfo.volume,
                         @"buy.quantity":@(goodCreateInfo.quantity),
                         @"buy.gnetwork": goodCreateInfo.network,
                         @"buy.isSerial" : @(goodCreateInfo.isSerial),
                         @"buy.isOriginal" : @(goodCreateInfo.isOriginal),
                         @"buy.isOriginalBox" : @(goodCreateInfo.isOriginalBox),
                         @"buy.price" : @(goodCreateInfo.price),
                         @"buy.deadline" : @(goodCreateInfo.deadline),
                         @"buy.duration" : @(goodCreateInfo.duration),
                         @"buy.isBrushMachine" : @(goodCreateInfo.isBrushMachine),
                         @"buy.isAnoy" : @(goodCreateInfo.isAnoy),
                         @"buy.addrId" : @(goodCreateInfo.addrId)
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
    return @"save_buy_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/buy");
}

-(NSString*)method
{
    return @"POST";
}

@end

@implementation HttpSaveStockInfoRequest

//save_stock_token	-6920059044539543718
//stock.depotId	2
//gbrand	14
//stock.gid	1666
//stock.gcolor	粉
//stock.gvolume	16G
//stock.gnetwork	全网通
//stock.isSerial	true
//stock.isOriginal	true
//stock.isOriginalBox	true
//stock.isBrushMachine	true
//stock.presale	1000
//stock.inprice	2599

-(instancetype)initWithGoodInfo:(GoodCreateInfo*)goodCreateInfo
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"stock.depotId" : @(goodCreateInfo.depotId),
                         @"gbrand" : @(goodCreateInfo.brand),
                         @"stock.gid" : @(goodCreateInfo.id),
                         @"stock.gcolor" : goodCreateInfo.color,
                         @"stock.gvolume": goodCreateInfo.volume,
                         @"stock.gnetwork": goodCreateInfo.network,
                         @"stock.isSerial" : @(goodCreateInfo.isSerial),
                         @"stock.isOriginal" : @(goodCreateInfo.isOriginal),
                         @"stock.isOriginalBox" : @(goodCreateInfo.isOriginalBox),
                         @"stock.isBrushMachine" : @(goodCreateInfo.isBrushMachine),
                         @"stock.inprice" : @(goodCreateInfo.price),
                         @"stock.presale":@(goodCreateInfo.quantity),
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
    return @"save_stock_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/stock");
}

-(NSString*)method
{
    return @"POST";
}


@end


