//
//  HttpOrder.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "OrderDefine.h"
#import "OrderDetailDTO.h"
@interface HttpOrderRequest : BaseHttpRequest

-(instancetype)initWithOrderListType:(MMOrderListStyle)type andPage:(NSUInteger)pn;

@end

@interface HttpOrderResponse : BaseHttpResponse

@property (nonatomic, readonly) NSDictionary* page;
@property (nonatomic, readonly) NSArray* orderLists;
@property (nonatomic, readonly) NSUInteger pageNumber;
@property (nonatomic, readonly) NSUInteger pageSize;
@property (nonatomic, readonly) NSUInteger totalPage;
@property (nonatomic, readonly) NSUInteger totalRow;

@property (nonatomic, strong) NSMutableArray* orderDetailDTOs;

@end

@interface HttpAllBuyOrderRequest : HttpOrderRequest
-(instancetype)initWithPage:(NSInteger)pn;
@end

@interface HttpAllSupplyOrderRequest : HttpOrderRequest
-(instancetype)initWithPage:(NSInteger)pn;

@end
