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

@interface StockSellInfo:NSObject

@property (nonatomic) NSInteger price;
@property (nonatomic) NSInteger sale;
@property (nonatomic) NSInteger num;
@property (nonatomic) NSInteger version;

@end

@interface HttpDepotQueryRequest : BaseHttpRequest

@end

@interface HttpDepotQueryResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray<DepotDTO*>* depotDtos;

@end

@interface HttpStockSellRequest : BaseHttpRequest

-(instancetype)initWithStocks:(StockSellInfo*)stocks;

@end
