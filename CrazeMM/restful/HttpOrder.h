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
#import "HttpListQuery.h"


@interface HttpOrderRequest : HttpListQueryRequest

-(instancetype)initWithOrderListType:(MMOrderListStyle)type andPage:(NSUInteger)pn;
-(instancetype)initWithOrderListType:(MMOrderListStyle)type andPage:(NSUInteger)pn andConditions:(NSDictionary*)conditions;

@end

@interface HttpOrderResponse : HttpListQueryResponse

//@property (nonatomic, readonly) NSDictionary* page;
//@property (nonatomic, readonly) NSArray* orderLists;
//@property (nonatomic, readonly) NSUInteger pageNumber;
//@property (nonatomic, readonly) NSUInteger pageSize;
//@property (nonatomic, readonly) NSUInteger totalPage;
//@property (nonatomic, readonly) NSUInteger totalRow;

//@property (nonatomic) NSInteger totalRow;
//@property (nonatomic) NSInteger pageNumber;
//@property (nonatomic) NSInteger totalPage;
//@property (nonatomic) NSInteger pageSize;
//@property (nonatomic, readonly) NSDictionary* page;
//@property (nonatomic, readonly) NSArray* list;
//@property (nonatomic, strong) NSMutableArray<BaseListDTO*>* dtos;
//-(BaseListDTO*)makeDtoWith:(NSDictionary*)dict;


@property (nonatomic, readonly) NSArray* orderDetailDTOs;

@end

@interface HttpAllBuyOrderRequest : HttpOrderRequest
-(instancetype)initWithPage:(NSInteger)pn;
-(instancetype)initWithPage:(NSInteger)pn andConditions:(NSDictionary*)conditions;
@end

@interface HttpAllSupplyOrderRequest : HttpOrderRequest
-(instancetype)initWithPage:(NSInteger)pn;
-(instancetype)initWithPage:(NSInteger)pn andConditions:(NSDictionary*)conditions;

@end
