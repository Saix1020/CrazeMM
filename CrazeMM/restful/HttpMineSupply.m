//
//  HttpMineSupply.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMineSupply.h"
#import "MineStockDTO.h"

@implementation HttpMineSupplyRequest

-(instancetype)initWithPageNumber:(NSInteger)pageNumber andState:(NSArray*)states
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"pn" : @(pageNumber),
                         @"state" : [states componentsJoinedByString:@","]
                         } mutableCopy];
    }
    
    return self;
}

-(instancetype)initStateNomalWithPageNumber:(NSInteger)pageNumber
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"pn" : @(pageNumber),
                         @"state" : @(kStateNomal),
                         } mutableCopy];
    }
    
    return self;
}

-(instancetype)initStateSoldOutWithPageNumber:(NSInteger)pageNumber
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"pn" : @(pageNumber),
                         @"state" : [@[@(kStateSoldOut), @(150)] componentsJoinedByString:@","], //  已认购
                         } mutableCopy];
    }
    
    return self;
}

-(instancetype)initStateOffShelfWithPageNumber:(NSInteger)pageNumber
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"pn" : @(pageNumber),
                         @"state" : [NSString stringWithFormat:@"%ld,%ld", kStateCanceled, kStateOverdua]
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/supply/mine");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpMineSupplyResponse class];
}

@end

@implementation HttpMineBuyRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/buy/mine");
}

-(Class)responseClass
{
    return [HttpMineBuyResponse class];
}

@end


@implementation HttpMineSupplyResponse

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.productDTOs = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.productList) {
        MineSupplyProductDTO* dto = [[MineSupplyProductDTO alloc] initWith:dict];
        NSLog(@"%@", dto);
        [self.productDTOs  addObject:dto];
    }
}

-(NSUInteger)pageNumber
{
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"pageNumber"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalPage
{
    
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"totalPage"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalRow
{
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"totalRow"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSArray*)productList
{
    if (self.all && self.all[@"page"]) {
        NSArray* productsList = self.all[@"page"][@"list"];
        return productsList;
    }
    
    return @[];
}

-(NSArray*)nomalProductDtos
{
    if (!self.productDTOs) {
        return @[];
    }
    
    else {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.state == %ld", kStateNomal];
        return [self.productDTOs filteredArrayUsingPredicate:predicate];
    }
}

-(NSArray*)offShelfProductDtos
{
    if (!self.productDTOs) {
        return @[];
    }
    
    else {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.state == %ld OR SELF.state == %ld", kStateCanceled, kStateOverdua];
        return [self.productDTOs filteredArrayUsingPredicate:predicate];
    }
}

-(NSArray*)dealProductDtos
{
    if (!self.productDTOs) {
        return @[];
    }
    
    else {
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF.state == %ld", kStateSoldOut];
        return [self.productDTOs filteredArrayUsingPredicate:predicate];
    }
}
@end

@implementation HttpMineBuyResponse

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.productDTOs = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.productList) {
        MineSupplyProductDTO* dto = [[MineBuyProductDTO alloc] initWith:dict];
        NSLog(@"%@", dto);
        [self.productDTOs  addObject:dto];
    }
    
}

@end


@implementation HttpMineStockRequest

-(instancetype)initWithPageNumber:(NSInteger)pageNumber
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"pn" : @(pageNumber),
                         } mutableCopy];
    }
    
    return self;
}

-(instancetype)initWithPageNumber:(NSInteger)pageNumber andStatus:(NSString*)status
{
    self = [self initWithPageNumber:pageNumber];
    if (self) {
        self.params[@"state"] = status;
    }
    return self;
}


-(NSString*)url
{
    return COMB_URL(@"/rest/stock");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpMineStockResponse class];
}

@end

@implementation HttpMineStockResponse

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.stockDTOs = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.stockList) {
        MineStockDTO* dto = [[MineStockDTO alloc] initWith:dict];
        NSLog(@"%@", dto);
        [self.stockDTOs  addObject:dto];
    }
    
}

-(NSUInteger)pageNumber
{
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"pageNumber"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalPage
{
    
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"totalPage"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalRow
{
    if (self.all && self.all[@"page"]) {
        NSNumber* number = self.all[@"page"][@"totalRow"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSArray*)stockList
{
    if (self.all && self.all[@"page"]) {
        NSArray* stockList = self.all[@"page"][@"list"];
        return stockList;
    }
    
    return @[];
}


@end


@implementation HttpMineSupplyDetailRequest

-(instancetype)initWithId:(NSInteger)sid
{
    self = [super init];
    if (self) {
        self.sid = sid;
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/supply/detail/%ld", self.sid];
    return COMB_URL(absUrl);
}

-(NSString*)method{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpMineSupplyDetailResponse class];
}

@end

@implementation HttpMineSupplyDetailResponse

-(NSDictionary*)supply
{
    return  self.all?self.all[@"supply"]:@{};
}

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    
    self.supplyDtailDto = [[MineSupplyDetailDTO alloc] initWith:self.supply];
}

@end


@implementation HttpMineBuyDetailRequest

-(instancetype)initWithId:(NSInteger)sid
{
    self = [super init];
    if (self) {
        self.bid = sid;
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/buy/detail/%ld", self.bid];
    return COMB_URL(absUrl);
}

-(NSString*)method{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpMineBuyDetailResponse class];
}

@end

@implementation HttpMineBuyDetailResponse

-(NSDictionary*)buy
{
    return  self.all?self.all[@"buy"]:@{};
}

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    
    self.buyDetailDto = [[MineBuyDetailDTO alloc] initWith:self.buy];
}

@end

@implementation HttpSupplyForMidifyRequest

-(instancetype)initWithId:(NSInteger)id
{
    self = [super init];
    if(self){
        self.id = id;
    }
    
    return self;
}

-(NSString*)url
{
    NSString* path = [NSString stringWithFormat:@"/rest/supply/supplyForModify/%ld", self.id];
    return COMB_URL(path);
}

-(Class)responseClass
{
    return [HttpSupplyForMidifyResponse class];
}

@end

@implementation HttpSupplyForMidifyResponse

-(NSDictionary*)data
{
    if (self.all) {
        return self.all[@"supply"];
    }
    
    return nil;
}

-(void)parserResponse
{
    self.goodCreateInfo = [[GoodCreateInfo alloc] initWith:self.data];
}

@end
