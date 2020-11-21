//
//  HttpOrderCancel.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrderCancel.h"

@interface HttpOrderCancelRequest()

@property(nonatomic) NSInteger orderId;
@end

@implementation HttpOrderCancelRequest

-(instancetype)initWithOderId:(NSInteger)orderId
{
    self = [super init];
    if (self) {
        self.orderId = orderId;
    }
    return self;
}

-(NSString*)url
{
    // change /rest/order/cancel/%ld to /rest/order/orderCancel/%ld
    NSString* url = [NSString stringWithFormat:@"/rest/order/orderCancel/%ld", self.orderId];
    return COMB_URL(url);
}

-(NSString*)method
{
    return @"GET";
}

@end
