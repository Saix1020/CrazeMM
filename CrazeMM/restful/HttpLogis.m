//
//  HttpLogis.m
//  CrazeMM
//
//  Created by saix on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpLogis.h"

@implementation HttpLogisRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/logis");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpLogisResponse class];
}

@end

@implementation HttpLogisResponse

-(void)parserResponse
{
    self.logises = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dict in self.data) {
        LogisDTO* dto = [[LogisDTO alloc] initWith:dict];
        [self.logises addObject:dto];
    }
}

@end