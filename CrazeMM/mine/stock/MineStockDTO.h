//
//  MineStockDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "DepotDTO.h"
#import "StockDetailDTO.h"

//{"depotName":"良晋栖霞仓库","gid":1666,"depot":{"name":"良晋栖霞仓库","id":2,"info":"位于江苏省南京市栖霞区"},"inprice":2999,"depotId":2,"gimage":"1666.png?_=1a87e118502ad52c2f84bbef380e968b","updateTime":"2016-06-03 00:44:41","presale":849,"aftersale":0,"gvolume":"16G","version":6,"isSerial":true,"uid":366,"isOriginal":true,"goodName":"苹果-iPhone SE 粉 16G 全网通","gcolor":"粉","isOriginalBox":true,"id":16,"insale":151,"gnetwork":"全网通","isBrushMachine":false},

@interface MineStockDTO : BaseDTO

@property (nonatomic, strong) NSString* depotName;
@property (nonatomic, strong) DepotDTO* depotDto;
@property (nonatomic) NSInteger earning;
@property (nonatomic) NSInteger gid;
@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger depotId;
@property (nonatomic) NSInteger presale;
@property (nonatomic) NSInteger aftersale;
@property (nonatomic) NSInteger version;
@property (nonatomic) NSInteger insale;
@property (nonatomic) NSInteger outstock;
@property (nonatomic) BOOL isSerial;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) BOOL isBrushMachine;
@property (nonatomic) float inprice;
@property (nonatomic, strong) NSString* gimage;
@property (nonatomic, strong) NSString* updateTime;
@property (nonatomic, strong) NSString* gvolume;
@property (nonatomic, strong) NSString* goodName;
@property (nonatomic, strong) NSString* goodImage;

@property (nonatomic, strong) NSString* gnetwork;
@property (nonatomic, strong) NSString* gcolor;
@property (nonatomic) NSInteger state;
@property (nonatomic, strong) NSString* stateLabel;


@property (nonatomic) BOOL selected;
@property (nonatomic) NSInteger currentPrice;
@property (nonatomic)NSInteger currentSale;
@property (nonatomic)NSInteger currentNum;


-(instancetype)initWithStockDetailDTO:(StockDetailDTO*)stockDetailDto;

@end
