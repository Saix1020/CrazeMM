//
//  HttpBuyRequest.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpBuyRequest.h"
#import "BuyProductDTO.h"

@implementation HttpBuyRequest

-(instancetype)initWithPageNumber:(NSUInteger)pageNumber;
{
    self = [super init];
    if (self) {
        self.pageNumber = pageNumber;
        self.params =  [@{
                          @"pn" : @(self.pageNumber),
                          //                          @"top" : @"true"
                          } mutableCopy];
    }
    
    return  self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/buy/top");
}


-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpBuyResponse class];
}

@end


@implementation HttpBuyResponse

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.productDTOs = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.productList) {
        BuyProductDTO* dto = [[BuyProductDTO alloc] initWith:dict];
        NSLog(@"%@", dto);
        [self.productDTOs  addObject:dto];
    }
    
}


@end


@implementation HttpBuyForMidifyRequest

-(NSString*)url
{
    NSString* path = [NSString stringWithFormat:@"/rest/buyForModify/%ld", self.id];
    return COMB_URL(path);
}

-(Class)responseClass
{
    return [HttpBuyForMidifyResponse class];
}

@end

@implementation HttpBuyForMidifyResponse



@end

