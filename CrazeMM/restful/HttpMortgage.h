//
//  HttpMortgage.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpListQuery.h"
#import "MortgageDTO.h"
#import "MortgageBrandDTO.h"
#import "MortgageGoodDTO.h"
#import "MortgageInfoDTO.h"


#pragma mark - HttpMortgage

@interface HttpMortgageRequest : HttpListQueryRequest
@property (nonatomic) NSInteger status;

-(instancetype)initWithPageNum:(NSInteger)pn andStatus:(NSInteger)status;

@end

@interface HttpMortgageResponse : HttpListQueryResponse

@end

#pragma mark - HttpMortgageBrand

@interface HttpMortgageBrandRequest : BaseHttpRequest

@end

@interface HttpMortgageBrandResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<MortgageBrandDTO*>* brandDtos;

@end

#pragma mark - HttpMortgageGood

@interface HttpMortgageGoodRequest : BaseHttpRequest

-(instancetype)initWithBrandId:(NSInteger)brandId;

@end

@interface HttpMortgageGoodResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<MortgageGoodDTO*>* goodDtos;

@end

#pragma mark - HttpMortgageInfo

@interface HttpMortgageInfoRequest : BaseHttpRequest

-(instancetype)initWithGoodId:(NSInteger)goodId;

@end

@interface HttpMortgageInfoResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<MortgageInfoDTO*>* infoDtos;

@end


#pragma mark - MortgageCreateInfo

@interface MortgageCreateInfo : NSObject

@property (nonatomic) NSInteger depotId;
@property (nonatomic) NSInteger mgId;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) CGFloat inprice;
@property (nonatomic) CGFloat outprice;

@end

#pragma mark - HttpSaveMortgageRequest

@interface HttpSaveMortgageRequest : BaseHttpRequest

-(instancetype)initWithMortgageInfo:(MortgageCreateInfo*)mortgageCreateInfo;

@end

#pragma mark - MortgageDelete
@interface HttpMortgageDeleteRequest : BaseHttpRequest

-(instancetype)initWithIds:(NSArray*)ids StockIds:(NSArray*)stockIds;

@end





