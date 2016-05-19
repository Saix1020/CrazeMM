//
//  HttpMineSupply.h
//  CrazeMM
//
//  Created by saix on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "MineSupplyProductDTO.h"

typedef NS_ENUM(NSInteger, MMMineSupplyState){
    kStateNomal = 100,
    kStateMortgage = 101,
    kStateSoldOut = 200,
    kStateCanceled = 400,
    kStateOverdua = 500
};

@interface HttpMineSupplyRequest : BaseHttpRequest

-(instancetype)initWithPageNumber:(NSInteger)pageNumber andState:(NSArray*)states;
-(instancetype)initStateOffShelfWithPageNumber:(NSInteger)pageNumber;
-(instancetype)initStateSoldOutWithPageNumber:(NSInteger)pageNumber;
-(instancetype)initStateNomalWithPageNumber:(NSInteger)pageNumber;

@end

@interface HttpMineSupplyResponse : BaseHttpResponse //

@property (nonatomic, readonly) NSArray* productList;
@property (nonatomic, readonly) NSUInteger pageNumber;
@property (nonatomic, readonly) NSUInteger totalPage;
@property (nonatomic, readonly) NSUInteger totalRow;
@property (nonatomic, strong) NSMutableArray<MineSupplyProductDTO*>* productDTOs;
@property (nonatomic, readonly) NSArray* nomalProductDtos;
@property (nonatomic, readonly) NSArray* offShelfProductDtos;
@property (nonatomic, readonly) NSArray* dealProductDtos;

@end
