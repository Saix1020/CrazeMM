//
//  HttpBalance.m
//  CrazeMM
//
//  Created by saix on 16/6/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpBalance.h"

@implementation HttpBalanceRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/balance/me");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpBalanceResponse class];
}


@end


@implementation HttpBalanceResponse

-(void)parserResponse
{
    if (self.all[@"balance"]) {
        self.balanceDto = [[BalanceDTO alloc] initWith:self.all[@"balance"]];
    }
}

@end

@implementation HttpBalanceLogRequest

-(instancetype)initWithPageNum:(NSInteger)pn
{
    self = [super init];
    if (self) {
        self.params = [@{
                        @"pn" : @(pn)
                        } mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/balance/log");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpBalanceLogResponse class];
}

@end

@implementation HttpBalanceLogResponse

-(NSDictionary*)page
{
    if (IsNilOrNull(self.all[@"page"])) {
        return @{};
    }
    else {
        return self.all[@"page"];
    }
}
-(void)parserResponse
{    
    self.totalRow = [self.page[@"totalRow"] integerValue];
    self.pageNumber = [self.page[@"pageNumber"] integerValue];
    self.totalPage = [self.page[@"totalPage"] integerValue];
    self.pageSize = [self.page[@"pageSize"] integerValue];
    self.balanceLogDtos = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in self.page[@"list"]) {
        BalanceLogDTO* dto = [[BalanceLogDTO alloc] initWith:dict];
        [self.balanceLogDtos addObject:dto];
    }

    self.balanceLogDtos = [[self.balanceLogDtos sortedArrayUsingComparator:^NSComparisonResult(BalanceLogDTO* obj1, BalanceLogDTO* obj2){
        return [obj2.createTime localizedCompare:obj1.createTime];
    }] mutableCopy];
    
}

@end
