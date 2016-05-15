//
//  HttpSupplyOrder.m
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSupplyOrder.h"

@implementation HttpSupplyOrderRequest


-(instancetype)initWithSid:(NSInteger)sid andVersion:(NSInteger)version andQuantity:(NSInteger)quantity andMessage:(NSString*)message
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"order.sid" : @(sid),
                         @"supply.version" : @(version),
                         @"order.quantity" : @(quantity),
                         @"order.message" : message,
                         @"orderType" : @"DIRECT_SUPPLY"
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/order");
}

-(NSString*)method
{
    return @"POST";
}

-(BOOL)needToken
{
    return YES;
}

-(NSString*)tokenName
{
    return @"save_order_token";
}

-(Class)responseClass
{
    return [HttpSupplyOrderResponse class];
}

@end

@implementation HttpSupplyOrderResponse

-(NSInteger)orderId
{
    if (self.data) {
        return [self.data[@"orderId"] integerValue];
    }
    else {
        return -1;
    }
}

@end
