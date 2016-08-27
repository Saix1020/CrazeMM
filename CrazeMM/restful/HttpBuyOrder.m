//
//  HttpBuyOrder.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpBuyOrder.h"

//* order.bid:299
//* buy.version:0
//* orderType:DIRECT_BUY
//* save_order_token:-5560935841381670327
//* order.quantity:10
//* order.message:


@implementation HttpBuyOrderRequest

-(instancetype)initWithBid:(NSInteger)bid andQuantity:(NSInteger)quantity andMessage:(NSString*)msg
{
    self = [self init];
    if (self) {
        self.params = [@{
                         @"order.bid" : @(bid),
                         @"buy.version" : @(0),
                         @"orderType" : @"DIRECT_BUY",
                         @"order.quantity" : @(quantity),
                         @"order.message" : msg
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


@end
