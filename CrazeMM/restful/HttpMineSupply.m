//
//  HttpMineSupply.m
//  CrazeMM
//
//  Created by saix on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMineSupply.h"

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
                         @"state" : @(kStateSoldOut),
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