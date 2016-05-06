//
//  HttpOrderSummary.m
//  CrazeMM
//
//  Created by saix on 16/5/5.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrderSummary.h"

@implementation HttpOrderSummaryRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/order/summary");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpOrderSummaryResponse class];
}

@end

@implementation HttpOrderSummaryResponse

//@property (nonatomic, readonly) NSDictionary* state;
//@property (nonatomic, readonly) NSDictionary* sum;
//@property (nonatomic, readonly) NSDictionary* buy;
//@property (nonatomic, readonly) NSDictionary* supply;
//@property (nonatomic, readonly) NSInteger tobepaid;
//@property (nonatomic, readonly) NSInteger tobereceived;
//@property (nonatomic, readonly) NSInteger tobesent;
//@property (nonatomic, readonly) NSInteger tobeconfirmed;

-(NSDictionary*)state
{
    if (!self.all) {
        return nil;
    }
    return self.all[@"state"];
}

-(NSDictionary*)sum
{
    if (!self.all) {
        return nil;
    }
    return self.all[@"sum"];
}

-(NSDictionary*)buy
{
    if (!self.sum) {
        return nil;
    }
    return self.sum[@"buy"];
}

-(NSDictionary*)supply
{
    if (!self.sum) {
        return nil;
    }
    return self.sum[@"supply"];
}

-(NSInteger)tobepaid
{
    if (!self.buy) {
        return 0;
    }
    
    return [self.buy[@"tobepaid"] integerValue];
}

-(NSInteger)tobereceived
{
    if (!self.buy) {
        return 0;
    }
    
    return [self.buy[@"tobereceived"] integerValue];
}

-(NSInteger)tobesent
{
    if (!self.supply) {
        return 0;
    }
    
    return [self.supply[@"tobesent"] integerValue];
}

-(NSInteger)tobeconfirmed
{
    if (!self.supply) {
        return 0;
    }
    
    return [self.supply[@"tobeconfirmed"] integerValue];
}

@end
