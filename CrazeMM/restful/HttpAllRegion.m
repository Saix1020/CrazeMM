//
//  HttpAllRegion.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpAllRegion.h"

static NSArray *sharedAllRegions = nil;


@implementation HttpAllRegionRequest

+(AFPromise*)getAllRegions
{
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        
        if(sharedAllRegions && sharedAllRegions.count>0){
            resolver(sharedAllRegions);
        }
        else {
            HttpAllRegionRequest* request = [[HttpAllRegionRequest alloc] init];
            [request request].then(^(id responseObj){
                
                HttpAllRegionResponse* response = (HttpAllRegionResponse*)request.response;
                if (response.ok) {
                    sharedAllRegions = [response.regionDtos copy];
                    resolver(sharedAllRegions);
                }
                else {
                    resolver(nil);
                }
                
            })
            .catch(^(NSError* error){
                resolver(nil);
            });
        }
    }];

}

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
