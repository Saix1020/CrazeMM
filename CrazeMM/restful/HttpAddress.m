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

@implementation HttpAddressDetailRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/addr");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpAddressDetailResponse class];
}


@end

@implementation HttpAddressDetailResponse

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
        AddrDTO* dto = [[AddrDTO alloc] initWith:addr];
        [self.addresses addObject:dto];
    }
}

@end


@implementation HttpAddressSaveRequest

-(instancetype)initWithAddrDto:(AddrDTO *)addrDto
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"address.contact" : addrDto.contact,
                         @"address.mobile" : addrDto.mobile,
                         @"address.pid" : @(addrDto.pid),
                             @"address.cid": @(addrDto.cid),
                             @"address.did": @(addrDto.did),
                             @"address.street": addrDto.street,
                             @"address.zipCode" : addrDto.zipCode,
                             @"address.isDefault" : @(addrDto.isDefault)
                         } mutableCopy];
        if (addrDto.uid>0) {
            [self.params setValue:@(addrDto.uid) forKey:@"address.uid"];
        }
    }
    return self;
}

-(BOOL)needToken
{
    return YES;
}

-(NSString*)tokenName
{
    return @"save_address_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/addr");
}

-(NSString*)method
{
    return @"POST";
}

@end