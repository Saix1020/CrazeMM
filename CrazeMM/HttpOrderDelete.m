//
//  HttpOrderDelete.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrderDelete.h"

@implementation HttpOrderDeleteRequest

-(instancetype)initWithOrderIds:(NSString*)orderIds
{
    self = [super init];
    self.ids = orderIds;
    if (self) {
        self.params = [@{
                         @"ids" : orderIds
                         } mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/remove/%@", self.ids];
    return COMB_URL(absUrl);
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpOrderDeleteResponse class];
}

@end


@implementation HttpOrderDeleteResponse

@end
