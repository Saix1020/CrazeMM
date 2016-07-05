//
//  MortgageDTO.m
//  CrazeMM
//
//  Created by saix on 16/6/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MortgageDTO.h"

@implementation MortgageDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        //@property (nonatomic) float interestRate;
//        @property (nonatomic) NSInteger quantity;
//        @property (nonatomic) NSInteger gid;
//        @property (nonatomic) NSInteger duration;
//        @property (nonatomic) float outPrice;
//        @property (nonatomic) float price;
//        @property (nonatomic) NSInteger stockId;
//        @property (nonatomic) NSInteger state;
//        
//        @property (nonatomic, copy) NSString* stateLabel;
//        @property (nonatomic, copy) NSString* depotName;
//        @property (nonatomic, copy) NSString* gimage;
//        @property (nonatomic, copy) NSString* updateTime;
//        @property (nonatomic, copy) NSString* goodName;
//        @property (nonatomic, copy) NSString* createTime;
        
        self.interestRate = [dict[@"interestRate"] floatValue];
        self.outPrice = [dict[@"outPrice"] floatValue];
        self.price = [dict[@"price"] floatValue];

        self.quantity = [dict[@"quantity"] integerValue];
        self.gid = [dict[@"gid"] integerValue];
        self.duration = [dict[@"duration"] integerValue];
        self.stockId = [dict[@"stockId"] integerValue];
        self.state = [dict[@"state"] integerValue];
        
        
        self.stateLabel = dict[@"stateLabel"];
        self.depotName = dict[@"depotName"];
        self.gimage = dict[@"gimage"];
        self.goodName = dict[@"goodName"];

        self.updateTime = dict[@"updateTime"];
        self.createTime = dict[@"createTime"];

    }
    return self;
}


@end
