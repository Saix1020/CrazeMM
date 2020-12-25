//
//  HttpMortgage.m
//  CrazeMM
//
//  Created by saix on 16/6/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMortgage.h"

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
