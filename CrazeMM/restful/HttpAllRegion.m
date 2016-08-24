//
//  HttpAllRegion.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpAllRegion.h"

@implementation HttpAllRegionRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/region");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpAllRegionResponse class];
}

@end

@implementation HttpAllRegionResponse

-(void)parserResponse
{
    @synchronized (self) {
        self.regionDtos = [[NSMutableArray alloc] init];
        for (NSDictionary* dict in self.data) {
            [self.regionDtos addObject: [[RegionDTO alloc] initWith:dict]];
        }
        
    }
}

@end
