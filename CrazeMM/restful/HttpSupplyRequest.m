//
//  HttpSupplyRequest.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSupplyRequest.h"

@implementation HttpSupplyRequest

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
    return COMB_URL(@"/rest/supply/top");
}


-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpSupplyResponse class];
}


@end


@implementation HttpSupplyResponse

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.productDTOs = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.productList) {
        SupplyProductDTO* dto = [[SupplyProductDTO alloc] initWith:dict];
        NSLog(@"%@", dto);
        [self.productDTOs  addObject:dto];
    }
    
}


@end

@implementation HttpSupplyForMidifyRequest

-(instancetype)initWithId:(NSInteger)id
{
    self = [super init];
    if(self){
        self.id = id;
    }
    
    return self;
}

-(NSString*)url
{
    NSString* path = [NSString stringWithFormat:@"/rest/supplyForModify/%ld", self.id];
    return COMB_URL(path);
}

-(Class)responseClass
{
    return [HttpSupplyForMidifyResponse class];
}

@end

@implementation HttpSupplyForMidifyResponse



@end
