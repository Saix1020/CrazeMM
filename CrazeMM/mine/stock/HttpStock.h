//
//  HttpStock.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "DepotDTO.h"
#import "MineStockDTO.h"
#import "StockDetailDTO.h"

@interface StockSellInfo : NSObject

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger sale;
@property (nonatomic) NSInteger num;
@property (nonatomic) NSInteger version;
@property (nonatomic) NSInteger sellId;

@end

@interface HttpDepotQueryRequest : BaseHttpRequest

@end

@interface HttpDepotQueryResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<DepotDTO*>* depotDtos;

@end

@interface HttpStockSellRequest : BaseHttpRequest

-(instancetype)initWithStocks:(StockSellInfo*)stocks;
@property (nonatomic)NSInteger sellId;

@end

@interface HttpStockDetailRequest : BaseHttpRequest

-(instancetype)initWithId:(NSInteger)stockId;
@property (nonatomic)NSInteger stockId;

@end

@interface HttpStockDetailResponse : BaseHttpResponse

@property (nonatomic, strong) StockDetailDTO* stockDto;

@end
