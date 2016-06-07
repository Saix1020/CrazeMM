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