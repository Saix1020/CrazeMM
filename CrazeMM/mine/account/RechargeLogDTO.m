//
//  RechargeLogDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "RechargeLogDTO.h"

@implementation RechargeLogDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    
    if (self) {
        self.no = [dict[@"no"] integerValue];
        self.uid = [dict[@"uid"] integerValue];
        self.method = [dict[@"method"] integerValue];
        self.state = [dict[@"state"] integerValue];
        
        self.methodDesc = dict[@"methodDesc"];
        self.createTime = dict[@"createTime"];
        self.stateDesc = dict[@"stateDesc"];
        self.updateTime = dict[@"updateTime"];
        self.comment = dict[@"comment"];

        self.money = [dict[@"money"] floatValue];

    }
    
    return self;
}

@end
