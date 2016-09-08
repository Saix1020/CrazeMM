//
//  HttpMortgage.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMortgage.h"

#pragma mark - HttpMortgage

@implementation HttpMortgageRequest

-(instancetype)initWithPageNum:(NSInteger)pn andStatus:(NSInteger)status
{
    self = [super initWithPageNum:pn];
    if (self) {
        self.status = status;
        self.params[@"state"] = @(status);
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/mortgage");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpMortgageResponse class];
}

@end

@implementation HttpMortgageResponse

-(BaseListDTO*)makeDtoWith:(NSDictionary*)dict
{
    MortgageDTO* dto = [[MortgageDTO alloc] initWith:dict];
    return dto;
}

@end

#pragma mark - HttpMortgageBrand

@implementation HttpMortgageBrandRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/goodMortgage/brand");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpMortgageBrandResponse class];
}

@end


@implementation HttpMortgageBrandResponse

-(void)parserResponse
{
    NSArray* brands = self.all[@"brand"];
    self.brandDtos = [[NSMutableArray alloc] init];
    
    for (NSDictionary* brand in brands) {
        NSLog(@"%@", brand);
        MortgageBrandDTO* dto = [[MortgageBrandDTO alloc] initWith:brand];
        [self.brandDtos addObject:dto];
    }
}

@end

#pragma mark - HttpMortgageGood

@implementation HttpMortgageGoodRequest

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
    return COMB_URL( @"/rest/goodMortgage/good");
}

-(NSString*)method
{
    return @"GET";
}

-(Class) responseClass
{
    return [HttpMortgageGoodResponse class];
}


@end

@implementation HttpMortgageGoodResponse

-(void)parserResponse
{
    self.goodDtos = [[NSMutableArray alloc] init];
    NSArray* goods = self.all[@"good"];
    for (NSDictionary* good in goods) {
        NSLog(@"%@", good);
        MortgageGoodDTO* dto = [[MortgageGoodDTO alloc] initWith:good];
        [self.goodDtos addObject:dto];
    }
}

@end

#pragma mark - HttpMortgageInfo

@implementation HttpMortgageInfoRequest

-(instancetype)initWithGoodId:(NSInteger)goodId
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"goodId" : @(goodId)
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL( @"/rest/goodMortgage");
}

-(NSString*)method
{
    return @"GET";
}

-(Class) responseClass
{
    return [HttpMortgageInfoResponse class];
}

@end

@implementation HttpMortgageInfoResponse

-(void)parserResponse
{
    self.infoDtos = [[NSMutableArray alloc] init];
    NSArray* mortgageGoods = self.all[@"mortgageGood"];
    for (NSDictionary* good in mortgageGoods) {
        NSLog(@"%@", good);
        MortgageInfoDTO* dto = [[MortgageInfoDTO alloc] initWith:good];
        [self.infoDtos addObject:dto];
    }
}

@end

#pragma mark - MortgageCreateInfo

@implementation MortgageCreateInfo

@end

#pragma mark - HttpSaveMortgageRequest

@implementation HttpSaveMortgageRequest

-(instancetype)initWithMortgageInfo:(MortgageCreateInfo*)mortgageCreateInfo
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"depotId" : @(mortgageCreateInfo.depotId),
                         @"mgId" : @(mortgageCreateInfo.mgId),
                         @"quantity" : @(mortgageCreateInfo.quantity),
                         @"inprice" : @(mortgageCreateInfo.inprice),
                         @"outprice" : @(mortgageCreateInfo.outprice)
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
    return @"save_mortgage_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/mortgage");
}

-(NSString*)method
{
    return @"POST";
}

@end

#pragma mark - MortgageDelete

@implementation HttpMortgageDeleteRequest

-(instancetype)initWithIds:(NSArray*)ids StockIds:(NSArray*)stockIds
{
    self = [super init];
    self.params = [@{
                     @"mortgageIds" : [ids componentsJoinedByString:@","],
                     @"stockIds" : [stockIds componentsJoinedByString:@","],
                     } mutableCopy];

    return self;
}


-(NSString*)url
{
    return COMB_URL( @"/rest/mortgage/delete");
}

-(NSString*)method
{
    return @"GET";
}

@end

#pragma mark - MortgageCancel

@implementation HttpMortgageCancelRequest

-(instancetype)initWithIds:(NSArray*)ids
{
    self = [super init];
    self.params = [@{
                     @"mortgageIds" : [ids componentsJoinedByString:@","],
                     } mutableCopy];
    
    return self;
}


-(NSString*)url
{
    return COMB_URL( @"/rest/mortgage/cancel");
}

-(NSString*)method
{
    return @"GET";
}

@end

#pragma mark - Now

@implementation HttpNowRequest

-(NSString*)url
{
    return COMB_URL( @"/rest/now");
}

-(NSString*)method
{
    return @"GET";
}

-(Class) responseClass
{
    return [HttpNowResponse class];
}

@end

@implementation HttpNowResponse

-(void)parserResponse
{
    if (self.all[@"now"])
    {
        self.now = [self.all[@"now"] integerValue];
    }
}

@end


#pragma - mark MortgageDetail

@implementation HttpMortgageDetailRequest

-(instancetype)initWithMortgageId:(NSInteger)mid
{
    self = [super init];
    if (self) {
        self.mid = mid;
    }
    
    return self;
    
}

-(NSString*)url
{
    NSString* path = [NSString stringWithFormat:@"/rest/mortgage/%ld", self.mid];
    return COMB_URL(path);
}

-(Class)responseClass
{
    return [HttpMortgageDetailResponse class];
}

@end

@implementation HttpMortgageDetailResponse

-(void)parserResponse
{
    self.detailDto = [[MortgageDetailDTO alloc] initWith:self.all[@"mortgage"]];
}

@end




