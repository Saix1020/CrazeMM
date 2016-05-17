//
//  HttpAddress.m
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpAddress.h"

@implementation HttpAddressRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/user/address");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpAddressResponse class];
}
@end


@implementation HttpAddressResponse

-(NSArray*)addr
{
    if (self.all) {
        return self.all[@"addr"];
    }
    return @[];
}

-(void)parserResponse
{
    self.addresses = [[NSMutableArray alloc] init];
    for (NSDictionary* addr in self.addr) {
        AddressDTO* dto = [[AddressDTO alloc] initWith:addr];
        [self.addresses addObject:dto];
    }
}

@end