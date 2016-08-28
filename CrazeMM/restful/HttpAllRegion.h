//
//  HttpAllRegion.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/23.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "RegionDTO.h"

@interface HttpAllRegionRequest : BaseHttpRequest

+(AFPromise*)getAllRegions;

@end

@interface HttpAllRegionResponse : BaseHttpResponse
@property (nonatomic, strong) NSMutableArray* regionDtos;

@end