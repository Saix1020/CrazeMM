//
//  HttpMobileBanner.m
//  CrazeMM
//
//  Created by saix on 16/10/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMobileBanner.h"

static NSArray *sharedAllBanners = nil;


@implementation HttpMobileBannerRequest

+(AFPromise*)getAllBanners
{
    return [AFPromise promiseWithResolverBlock:^(PMKResolver resolver){
        
        if(sharedAllBanners && sharedAllBanners.count>0){
            resolver(sharedAllBanners);
        }
        else {
            HttpMobileBannerRequest* request = [[HttpMobileBannerRequest alloc] init];
            [request request].then(^(id responseObj){
                
                HttpMobileBannerResponse* response = (HttpMobileBannerResponse*)request.response;
                if (response.ok) {
                    sharedAllBanners = [response.banners copy];
                    resolver(sharedAllBanners);
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
    return COMB_URL(@"/banner/getMobileBanner");
}


-(Class)responseClass
{
    return [HttpMobileBannerResponse class];
}

@end



@implementation HttpMobileBannerResponse


-(void)parserResponse
{
    if (self.all) {
        self.banners = [[NSMutableArray alloc] init];
        NSArray* array = self.all[@"data"];
        
        for (NSDictionary* dict in array) {
            BannerDTO* dto = [[BannerDTO alloc] initWith:dict];
            [self.banners addObject:dto];
        }
        
        [self.banners sortUsingComparator:^NSComparisonResult(BannerDTO* d1, BannerDTO* d2){
            return d1.orderNum < d2.orderNum;
        }];
    }
}

@end
