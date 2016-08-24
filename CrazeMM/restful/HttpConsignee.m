//
//  HttpConsignee.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpConsignee.h"

@implementation HttpConsigneeRequest


-(NSString*)url
{
    return COMB_URL(@"/rest/consignee");
}

-(Class)responseClass
{
    return [HttpConsigneeResponse class];
}

@end

@implementation HttpConsigneeResponse

-(NSDictionary*)consignee
{
    return self.all?self.all[@"consignee"] : nil;
}

-(void)parserResponse
{
    //[super parserResponse];
    self.consigneeDtos = [[NSMutableArray alloc] init];
    for (NSDictionary* dict in self.consignee) {
        ConsigneeDTO* dto = [[ConsigneeDTO alloc] initWith:dict];
        [self.consigneeDtos addObject:dto];
    }
}

@end


@implementation HttpSaveConsigneeRequest
//consignee.name:xs
//consignee.identity:321181198210200410
//consignee.mobile:18652072429

-(instancetype)initWithName:(NSString *)name andIdentity:(NSString *)identity andMobile:(NSString *)mobile
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"consignee.name" : name,
                         @"consignee.identity" : identity,
                         @"consignee.mobile" : mobile
                         } mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/consignee");
}

-(NSString*)method
{
    return @"POST";
}


@end

@implementation HttpDeleteConsigneeRequest

-(instancetype)initWithCId:(NSInteger)cid
{
    self = [self init];
    if (self) {
        self.cid = cid;
    }
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/consignee/delete/%ld", self.cid];
    return COMB_URL(absUrl);
}


@end
