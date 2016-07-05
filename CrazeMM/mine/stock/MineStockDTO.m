//
//  MineStockDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/31.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineStockDTO.h"

@implementation MineStockDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.depotDto = [[DepotDTO alloc] initWith:dict[@"depot"]];
    
        self.inprice = [dict[@"inprice"] floatValue];
        self.gid = [dict[@"gid"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
        self.depotId = [dict[@"depotId"] integerValue];
        self.version = [dict[@"version"] integerValue];
        
        self.afterout = [dict[@"afterout"] integerValue];
        self.inmortgage = [dict[@"inmortgage"] integerValue];
        self.insale = [dict[@"insale"] integerValue];
        self.aftersale = [dict[@"aftersale"] integerValue];
        self.presale = [dict[@"presale"] integerValue];
        self.outstock = [dict[@"outstock"] integerValue];

        
        
        self.isSerial = [dict[@"isSerial"] boolValue];
        self.isOriginal = [dict[@"isOriginal"] boolValue];
        self.isOriginalBox = [dict[@"isOriginalBox"] boolValue];
        self.isBrushMachine = [dict[@"isBrushMachine"] boolValue];

        self.updateTime = dict[@"updateTime"];
        self.depotName = dict[@"depotName"];
        self.gimage = dict[@"gimage"];
        self.gvolume = dict[@"gvolume"];
        self.goodName = dict[@"goodName"];
        self.goodImage = dict[@"goodImage"];

        self.gnetwork = dict[@"gnetwork"];
        self.gnetwork = dict[@"gcolor"];

        
        self.state = [dict[@"state"] integerValue];
        self.stateLabel = dict[@"stateLabel"];
        
        self.currentPrice = self.inprice;
        self.currentSale = self.presale;
        self.currentNum = self.seperateNum = 1;

        self.selected = NO;
    }
    return self;
}

-(NSInteger)total
{
    return _presale + _insale + _outstock + _afterout + _inmortgage + _aftersale;
}

-(instancetype)initWithStockDetailDTO:(StockDetailDTO*)stockDetailDto
{
    self = [super init];
    if (self) {
        self.gid = stockDetailDto.gid;
        self.depotId = stockDetailDto.depotId;
        self.version = stockDetailDto.version;
        self.uid = stockDetailDto.uid;
        self.inprice = stockDetailDto.inprice;
        self.isSerial = stockDetailDto.isSerial;
        self.isOriginal = stockDetailDto.isOriginal;
        self.isOriginalBox = stockDetailDto.isOriginalBox;
        self.updateTime = stockDetailDto.updateTime;
        self.gvolume = stockDetailDto.gvolume;
        self.gnetwork = stockDetailDto.gnetwork;
        self.gcolor = stockDetailDto.gcolor;
        self.goodName = stockDetailDto.goodName;
        
        self.afterout = stockDetailDto.afterout;
        self.inmortgage = stockDetailDto.inmortgage;
        self.insale = stockDetailDto.insale;
        self.aftersale = stockDetailDto.aftersale;
        self.presale = stockDetailDto.presale;
        self.outstock = stockDetailDto.outstock;
        
        
        self.currentPrice = self.inprice;
        self.currentSale = self.presale;
        self.currentNum = self.seperateNum = 1;
        self.selected = NO;

    }
    return self;
}

@end
