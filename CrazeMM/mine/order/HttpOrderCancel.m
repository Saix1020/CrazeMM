//
//  HttpOrderCancel.m
//  CrazeMM
//
//  Created by saix on 16/5/13.
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
    NSString* url = [NSString stringWithFormat:@"/rest/order/cancel/%ld", self.orderId];
    return COMB_URL(url);
}

-(NSString*)method
{
    return @"GET";
}

@end
