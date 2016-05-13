//
//  HttpProductDetail.m
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpProductDetail.h"

@implementation HttpSupplyProductDetailRequest

-(instancetype)initWithProductId:(NSInteger)id
{
    self = [super init];
    if (self){
        self.productId = id;
    }
    return self;
}

-(NSString*)url
{
    NSString* fullURL = [NSString stringWithFormat:@"/rest/supply/%ld", self.productId];
    return COMB_URL(fullURL);
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpSupplyProductDetailResponse class];
}

@end


@implementation HttpSupplyProductDetailResponse

-(NSDictionary*)supply
{
    if (!self.all) {
        return @{};
    }
    else {
        return self.all[@"supply"];
    }
}

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.dto = [[SupplyProductDetailDTO alloc] initWith:self.supply];
}

@end


@implementation HttpBuyProductDetailRequest

-(instancetype)initWithProductId:(NSInteger)id
{
    self = [super init];
    if (self){
        self.productId = id;
    }
    return self;
}

-(NSString*)url
{
    NSString* fullURL = [NSString stringWithFormat:@"/rest/buy/%ld", self.productId];
    return COMB_URL(fullURL);
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpBuyProductDetailResponse class];
}

@end


@implementation HttpBuyProductDetailResponse

-(NSDictionary*)supply
{
    if (!self.all) {
        return @{};
    }
    else {
        return self.all[@"buy"];
    }
}

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.dto = [[BuyProductDetailDTO alloc] initWith:self.supply];
}

@end



