//
//  HttpGoodInfoQuery.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpGoodInfoQuery.h"

@implementation HttpBrandQueryRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/brand");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpBrandQueryResponse class];
}

@end

@implementation HttpBrandQueryResponse

-(void)parserResponse
{
    NSArray* brands = self.all[@"brand"];
    self.brandDtos = [[NSMutableArray alloc] init];

    for (NSDictionary* brand in brands) {
        NSLog(@"%@", brand);
        GoodBrandDTO* dto = [[GoodBrandDTO alloc] initWith:brand];
        [self.brandDtos addObject:dto];
    }
}

@end

@implementation HttpGoodInfoQueryRequest

-(instancetype)initWithBrandId:(NSInteger)brandId
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"brandId" : @(brandId)
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL( @"/rest/good");
}

-(NSString*)method
{
    return @"GET";
}

-(Class) responseClass
{
    return [HttpGoodInfoQueryResponse class];
}

@end

@implementation HttpGoodInfoQueryResponse

-(void)parserResponse
{
    self.goodDtos = [[NSMutableArray alloc] init];
    NSArray* goods = self.all[@"good"];
    for (NSDictionary* good in goods) {
        NSLog(@"%@", good);
        GoodInfoDTO* dto = [[GoodInfoDTO alloc] initWith:good];
        [self.goodDtos addObject:dto];
    }
}

@end