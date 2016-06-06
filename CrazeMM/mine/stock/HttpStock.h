//
//  HttpStock.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "DepotDTO.h"
#import "GoodCreateInfo.h"

@interface HttpDepotQueryRequest : BaseHttpRequest

@end

@interface HttpDepotQueryResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<DepotDTO*>* depotDtos;

@end


@interface HttpSaveStockInfoRequest : BaseHttpRequest

-(instancetype)initWithGoodInfo:(GoodCreateInfo*)goodCreateInfo;

@end
