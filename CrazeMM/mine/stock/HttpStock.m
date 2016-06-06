//
//  HttpStock.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpStock.h"

@implementation HttpDepotQueryRequest


-(NSString*)url
{
    return COMB_URL(@"/rest/depot");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpDepotQueryResponse class];
}

@end

@implementation HttpDepotQueryResponse

-(void)parserResponse
{
    NSArray* depots = self.all[@"depot"];
    self.depotDtos = [[NSMutableArray alloc] init];
    
    for (NSDictionary* depot in depots) {
        NSLog(@"%@", depot);
        DepotDTO* dto = [[DepotDTO alloc] initWith:depot];
        [self.depotDtos addObject:dto];
    }
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

