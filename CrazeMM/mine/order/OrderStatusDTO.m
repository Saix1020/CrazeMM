//
//  OrderStatusDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderStatusDTO.h"

@implementation OrderStatusDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    
    if (self) {
        self.isAnoy = [dict[@"isAnoy"] boolValue];
        self.quantity = [dict[@"quantity"] integerValue];
        self.state = [dict[@"state"] integerValue];
        self.price = [dict[@"price"] floatValue];
        self.updateTime = dict[@"updateTime"];
        self.userImage = dict[@"userImage"];
        self.goodName = dict[@"goodName"];
        self.goodImage = dict[@"goodImage"];

        self.userName = dict[@"userName"];
        if(dict[@"addr"] && ![dict[@"addr"] isKindOfClass:[NSNull class]]){
            self.addr = [[AddrDTO alloc] initWith:dict[@"addr"]];
        }
        self.logs = [[NSMutableArray alloc] init];
        for (NSDictionary* log in dict[@"logs"]) {
            [self.logs addObject:[[OrderLogDTO alloc] initWith:log]];
        }
    }
    return self;
}


@end

@implementation OrderLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.uid = [dict[@"uid"] integerValue];
        self.oldState = [dict[@"oldState"] integerValue];
        self.oid = [dict[@"oid"] integerValue];
        self.newState = [dict[@"newState"] integerValue];
        
        self.stateLabelNew = dict[@"newStateLabel"];
        self.createTime = dict[@"createTime"];
        self.comment = dict[@"comment"];
        self.userName = dict[@"userName"];
    }
    return self;
}

@end
