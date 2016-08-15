//
//  HttpOrderStatus.m
//  CrazeMM
//
//  Created by saix on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrderStatus.h"

@implementation HttpOrderStatusRequest

-(instancetype)initWithOrderId:(NSInteger)orderId andOderType:(MMOrderType)orderType
{
    self = [super init];
    if (self) {
        self.orderId = orderId;
        self.params = [@{
                         @"t" : orderType==kOrderTypeBuy ? @"b" : @"s"
                        } mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/%ld", self.orderId];
    return COMB_URL(absUrl);
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpOrderStatusResponse class];
}

@end

@implementation HttpOrderStatusResponse

-(NSDictionary*)order
{
    if (self.all) {
        return self.all[@"order"];
    }
    else {
        return @{};
    }
}


-(void)parserResponse
{
    self.orderStatusDto = [[OrderStatusDTO alloc] initWith:self.order];
}


@end
