//
//  HttpSupplyRequest.h
//  CrazeMM
//
//  Created by saix on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "ProductDescriptionDTO.h"

@interface HttpSupplyRequest : BaseHttpRequest

@end


@interface HttpSupplyResponse : BaseHttpResponse

//        pageNumber = 1;
//        pageSize = 10;
//        totalPage = 135;
//        totalRow = 1341;


@property (nonatomic, readonly) NSArray* productList;
@property (nonatomic, readonly) NSUInteger pageNumber;
@property (nonatomic, readonly) NSUInteger totalPage;
@property (nonatomic, readonly) NSUInteger totalRow;
@property (nonatomic, strong) NSMutableArray<ProductDescriptionDTO*>* productDTOs;
@end