//
//  HttpStock.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpStock.h"

@implementation HttpDepotQueryRequest


-(NSString*)url
{
    return COMB_URL(@"/rest/depot");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpDepotQueryResponse class];
}

@end

@implementation HttpDepotQueryResponse

-(void)parserResponse
{
    NSArray* depots = self.all[@"depot"];
    self.depotDtos = [[NSMutableArray alloc] init];
    
    for (NSDictionary* depot in depots) {
        NSLog(@"%@", depot);
        DepotDTO* dto = [[DepotDTO alloc] initWith:depot];
        [self.depotDtos addObject:dto];
    }
}

@end

