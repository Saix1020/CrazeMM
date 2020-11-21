//
//  HttpMineBuy.m
//  CrazeMM
//
//  Created by saix on 16/9/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMineBuy.h"

@implementation HttpMineBuy

@end


@implementation HttpBuyForMidifyRequest

-(NSString*)url
{
    NSString* path = [NSString stringWithFormat:@"/rest/buy/buyForModify/%ld", self.id];
    return COMB_URL(path);
}

-(Class)responseClass
{
    return [HttpBuyForMidifyResponse class];
}

@end

@implementation HttpBuyForMidifyResponse

-(NSDictionary*)data
{
    if (self.all) {
        return self.all[@"buy"];
    }
    
    return nil;
}

-(void)parserResponse
{
    self.goodCreateInfo = [[GoodCreateInfo alloc] initWith:self.data];
}

@end