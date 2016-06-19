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
        self.presale = [dict[@"presale"] integerValue];
        self.gid = [dict[@"gid"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
        self.depotId = [dict[@"depotId"] integerValue];
        self.aftersale = [dict[@"aftersale"] integerValue];
        self.version = [dict[@"version"] integerValue];
        self.insale = [dict[@"insale"] integerValue];
        
        self.isSerial = [dict[@"isSerial"] boolValue];
        self.isOriginal = [dict[@"isOriginal"] boolValue];
        self.isOriginalBox = [dict[@"isOriginalBox"] boolValue];
        self.isBrushMachine = [dict[@"isBrushMachine"] boolValue];

        self.updateTime = dict[@"updateTime"];
        self.depotName = dict[@"depotName"];
        self.gimage = dict[@"gimage"];
        self.gvolume = dict[@"gvolume"];
        self.goodName = dict[@"goodName"];
        self.gnetwork = dict[@"gnetwork"];
        
        self.state = [dict[@"state"] integerValue];
        self.stateLabel = dict[@"stateLabel"];

        self.selected = NO;
    }
    return self;
}

@end
