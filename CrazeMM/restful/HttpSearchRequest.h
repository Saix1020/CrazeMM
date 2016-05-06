//
//  HttpSearchRequest.h
//  CrazeMM
//
//  Created by saix on 16/5/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "SearchResultDTO.h"

typedef NS_ENUM(NSInteger, SearchSortType){
    kComprehensiveSortType = 0,
    kPriceIncrease = 10,
    kPriceDecrease = 11,
    kAmountIncrease = 20,
    kAmountDecrease = 21
};

typedef NS_ENUM(NSInteger, SearchCategory){
    kSupplySearch = 0,
    kBuySearch = 1
};

@interface HttpSearchRequest : BaseHttpRequest

@property (nonatomic) NSUInteger pageNumber;
@property (nonatomic, copy) NSArray* keywords;
@property (nonatomic) SearchSortType sortType;
@property (nonatomic) SearchCategory categrory;


-(instancetype)initWithPageNumber:(NSUInteger)pageNumber andKeywords:(NSArray*)keywords andSorts:(SearchSortType)sortType andCategory:(SearchCategory)categrory;

@end


@interface HttpSearchResponse : BaseHttpResponse

//        pageNumber = 1;
//        pageSize = 10;
//        totalPage = 135;
//        totalRow = 1341;


@property (nonatomic, readonly) NSArray* productList;
@property (nonatomic, readonly) NSUInteger pageNumber;
@property (nonatomic, readonly) NSUInteger totalPage;
@property (nonatomic, readonly) NSUInteger totalRow;
@property (nonatomic, strong) NSMutableArray<SearchResultDTO*>* productDTOs;

@end