//
//  HttpRechargeLog.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpRechargeLog.h"

@implementation HttpRechargeLogRequest

-(NSString*)url
{
    return  COMB_URL(@"/rest/recharge") ;
}

-(Class)responseClass
{
    return [HttpRechargeLogResponse class];
}

@end

@implementation HttpRechargeLogResponse

-(id)makeDtoWith:(NSDictionary*)dict
{
    RechargeLogDTO* dto = [[RechargeLogDTO alloc] initWith:dict];
    return dto;
}

@end