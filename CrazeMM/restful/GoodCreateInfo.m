//
//  GoodCreateInfo.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/4.
//  Copyright © 2016年 189. All rights reserved.
//

#import "GoodCreateInfo.h"

@interface GoodCreateInfo()


@end


@implementation GoodCreateInfo

-(GoodInfoDTO*)brandInfo
{
    if (!_brandInfo) {
        _brandInfo = [[GoodInfoDTO alloc] initWith:self.addtionalInfo];
    }
    
    return _brandInfo;
}

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        
        self.addtionalInfo = dict[@"good"];
        
        self.id = [self.addtionalInfo[@"id"] integerValue];
        self.depotId = [dict[@"depotId"] integerValue];
        self.brand = self.brandInfo.brandId;
        self.brandName = self.brandInfo.brandName;
        self.quantity = [dict[@"quantity"] integerValue];
        self.deadline = [dict[@"deadline"] integerValue];
        self.duration = [dict[@"duration"] integerValue];
        self.price = [dict[@"price"] floatValue];
        self.color = dict[@"gcolor"];
        self.volume = dict[@"gvolume"];
        self.network = dict[@"gnetwork"];
        
        self.isAnoy = dict[@"isAnoy"];
        self.isOriginal = dict[@"isOriginal"];
        self.isOriginalBox = dict[@"isOriginalBox"];
        self.isBrushMachine = dict[@"isBrushMachine"];
        self.isBrushMachine = dict[@"isBrushMachine"];
        self.isSplit = dict[@"isSplit"];
        self.isAnoy = dict[@"isAnoy"];
        
        
        self.version = [dict[@"version"] integerValue];
        
        
        self.addr = [[AddressDTO alloc] initWith:dict[@"addr"]];
        self.addrId = self.addr.id;
        self.addrList = [[NSMutableArray alloc] init];
        for(NSDictionary* d in dict[@"addrList"]){
            [self.addrList addObject:[[AddressDTO alloc] initWith:d]];
        }
        self.userDto = dict[@"user"];
        
        self.stockInfo = dict[@"onlyStock"];
        self.state = [dict[@"state"] integerValue];
        self.isStockedGood = [dict[@"isStock"] boolValue];
        self.isMortgage = [dict[@"isMortgage"] boolValue];
    }
    
    return self;
}

//-(BOOL)isStockedGood
//{
//    return self.stockInfo && self.stockInfo[@"depot"];
//}

-(NSInteger)presale
{
    if (self.isStockedGood) {
        return [self.stockInfo[@"presale"] integerValue];
    }
    
    return 0;
}



@end

@implementation SupplyGoodCreateDto


@end

@implementation BuyGoodCreateDto

//-(instancetype)initWith:(NSDictionary *)dict
//{
//    self = [super initWith:dict];
//    if (self) {
//        self.addrId = [dict[@"addrId"] integerValue];
//        
//    }
//    return  self;
//}

@end