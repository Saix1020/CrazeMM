//
//  StockDetailDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "StockDetailDTO.h"

@implementation StockLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.quantity = [dict[@"quantity"] integerValue];
        self.stockId = [dict[@"stockId"] integerValue];
        self.createTime = dict[@"createTime"];
        self.content = dict[@"content"];
    }
    return self;
}

@end

@implementation StockDetailDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.gid = [dict[@"gid"] integerValue];
        self.depotId = [dict[@"depotId"] integerValue];
        self.version = [dict[@"version"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
        self.inprice = [dict[@"inprice"] floatValue];
        
        
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
        self.isMortgage = [dict[@"isMortgage"] boolValue];

        self.updateTime = dict[@"updateTime"];
        self.gvolume = dict[@"gvolume"];
        self.gcolor = dict[@"gcolor"];
        self.gnetwork = dict[@"gnetwork"];
        self.goodName = dict[@"goodName"];
        
        [self parserStockLog:dict[@"logs"]];
        
        self.selected = NO;
        
        self.currentPrice = self.inprice;
        self.currentSale = self.presale;
        self.currentNum = 1;
        
        self.currentPrice = self.inprice;
        self.currentSale = self.presale;

    }
    return self;
}

-(void)parserStockLog:(NSArray*) stockLogs
{
    self.logs = [[NSMutableArray alloc]init];
    
    for (NSDictionary* stockLog in stockLogs) {
        StockLogDTO* log = [[StockLogDTO alloc] initWith:stockLog];
        [self.logs addObject:log];
    }
}

-(NSInteger)total
{
    return _presale+_insale+_outstock+_afterout+_inmortgage+_aftersale;
}


@end
