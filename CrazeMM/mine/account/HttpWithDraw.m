//
//  HttpWithDraw.m
//  CrazeMM
//
//  Created by saix on 16/6/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpWithDraw.h"

@implementation HttpWithDrawRequest

-(instancetype)initWithBid:(NSInteger)bid andPassword:(NSString*)password andAmount:(CGFloat)amount
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"password" : password,
                         @"bid" : @(bid),
                         @"amount" : @(amount)
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/balance/withdraw");
}

-(NSString*)method
{
    return @"POST";
}

@end


@implementation HttpWithDrawLogRequest

-(NSString*)url
{
    return  COMB_URL(@"/rest/withdraw") ;
}

-(Class)responseClass
{
    return [HttpWithDrawLogResponse class];
}

@end

@implementation HttpWithDrawLogResponse

-(id)makeDtoWith:(NSDictionary*)dict
{
    WithDrawLogDTO* dto = [[WithDrawLogDTO alloc] initWith:dict];
    return dto;
}

@end

