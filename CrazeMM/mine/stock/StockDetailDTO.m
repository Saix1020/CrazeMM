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
        self.presale = [dict[@"presale"] integerValue];
        self.aftersale = [dict[@"aftersale"] integerValue];
        self.version = [dict[@"version"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
        self.insale = [dict[@"insale"] integerValue];
        self.inprice = [dict[@"inprice"] floatValue];
        
        self.isSerial = [dict[@"isSerial"] boolValue];
        self.isOriginal = [dict[@"isOriginal"] boolValue];
        self.isOriginalBox = [dict[@"isOriginalBox"] boolValue];
        self.isBrushMachine = [dict[@"isBrushMachine"] boolValue];
        
        self.updateTime = dict[@"updateTime"];
        self.gvolume = dict[@"gvolume"];
        self.gcolor = dict[@"gcolor"];
        self.gnetwork = dict[@"gnetwork"];
        self.goodName = dict[@"goodName"];
        
        [self parserStockLog:dict[@"logs"]];
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


@end
