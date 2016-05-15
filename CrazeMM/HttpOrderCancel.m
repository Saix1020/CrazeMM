//
//  HttpOrderCancel.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/14.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrderCancel.h"

@implementation HttpOrderCancelRequest

-(instancetype)initWithOrderId:(NSInteger)orderId
{
    self = [super init];
    if (self) {
        self.orderId = orderId;
        self.params = [@{
                         @"id" : @(orderId)
                         } mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/cancel/%ld", self.orderId];
    return COMB_URL(absUrl);
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpOrderCancelResponse class];
}

@end

@implementation HttpOrderCancelResponse


@end

