//
//  HttpMobileBanner.h
//  CrazeMM
//
//  Created by saix on 16/10/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "BannerDTO.h"

@interface HttpMobileBannerRequest : BaseHttpRequest

+(AFPromise*)getAllBanners;


@end


@interface HttpMobileBannerResponse : BaseHttpResponse


@property (nonatomic, strong) NSMutableArray* banners;


@end
