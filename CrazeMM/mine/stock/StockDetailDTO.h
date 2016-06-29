//
//  StockDetailDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface StockLogDTO : BaseDTO

@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger stockId;

@property (nonatomic, strong) NSString* createTime;
@property (nonatomic, strong) NSString* content;

@end

@interface StockDetailDTO : BaseDTO
//{"ok":true,"stock":{"gid":1666,"inprice":2999,"depotId":2,"updateTime":"2016-06-01 13:00:58","presale":900,"aftersale":0,"gvolume":"16G","version":1,"isSerial":true,"uid":366,"isOriginal":true,"gcolor":"粉","isOriginalBox":true,"id":16,"insale":100,"gnetwork":"全网通","isBrushMachine":false,"logs":[{"quantity":100,"createTime":"2016-06-01 13:00:58","stockId":16,"id":85,"content":"库存出货转手: 价格 3000.00, 数量 100, 供货单数 1 [1829]"},{"quantity":1000,"createTime":"2016-05-31 22:59:09","stockId":16,"id":41,"content":"添加库存记录"}]}}

@property (nonatomic) NSInteger gid;
@property (nonatomic) NSInteger depotId;
@property (nonatomic) NSInteger presale;
@property (nonatomic) NSInteger aftersale;
@property (nonatomic) NSInteger version;
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger insale;

@property (nonatomic) CGFloat inprice;

@property (nonatomic) BOOL isSerial;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) BOOL isBrushMachine;
@property (nonatomic) BOOL isMortgage;

@property (nonatomic, strong) NSString* updateTime;
@property (nonatomic, strong) NSString* gvolume;
@property (nonatomic, strong) NSString* gcolor;
@property (nonatomic, strong) NSString* gnetwork;
@property (nonatomic, strong) NSString* goodName;

@property (nonatomic, strong) NSMutableArray<StockLogDTO*>* logs;

@property (nonatomic) float earning;
@property (nonatomic) BOOL selected;
@property (nonatomic) NSInteger currentPrice;
@property (nonatomic) NSInteger currentSale;
@property (nonatomic) NSInteger currentNum;

@end
