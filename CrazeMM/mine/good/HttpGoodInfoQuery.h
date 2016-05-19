//
//  HttpGoodInfoQuery.h
//  CrazeMM
//
//  Created by saix on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "GoodDTO.h"

@interface HttpBrandQueryRequest : BaseHttpRequest

@end

@interface HttpBrandQueryResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<GoodBrandDTO*>* brandDtos;

@end


@interface HttpGoodInfoQueryRequest : BaseHttpRequest

-(instancetype)initWithBrandId:(NSInteger)brandId;

@end

@interface HttpGoodInfoQueryResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<GoodInfoDTO*>* goodDtos;

@end
