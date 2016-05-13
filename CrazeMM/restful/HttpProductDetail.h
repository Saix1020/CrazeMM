//
//  HttpProductDetail.h
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "SupplyProductDetailDTO.h"

@interface HttpSupplyProductDetailRequest : BaseHttpRequest

@property (nonatomic) NSInteger productId;

-(instancetype)initWithProductId:(NSInteger)id;

@end


@interface HttpSupplyProductDetailResponse : BaseHttpResponse

@property (nonatomic, strong) SupplyProductDetailDTO* dto;

@property (nonatomic, readonly) NSDictionary* supply;

@end