//
//  MineUserInfoDTO.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MineUserInfoDTO.h"

@implementation MineUserInfoDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super initWith:dict];
    if (self) {
        self.image = dict[@"image"];
        self.salt = dict[@"salt"];
        self.mobile = dict[@"mobile"];
        self.validateTime = dict[@"validateTime"];
        self.loginTime = dict[@"loginTime"];
        self.password = dict[@"password"];
        self.createTime = dict[@"createTime"];
        self.email = dict[@"email"];
        self.username = dict[@"username"];

        self.recommend = [dict[@"recommend"] boolValue];
        self.validated = [dict[@"validated"] boolValue];
        self.disabled = [dict[@"disabled"] boolValue];
        self.notifyAccept = [dict[@"notifyAccept"] boolValue];
        self.notifyRemind = [dict[@"notifyRemind"] boolValue];

        self.validateState = [dict[@"validateState"] integerValue];
        self.type = [dict[@"type"] integerValue];
        self.classification = [dict[@"classification"] integerValue];
        self.invoiceNumber = [dict[@"invoiceNumber"] integerValue];
        self.wx_id = [dict[@"wx_id"] integerValue];

    }
    
    return self;
}

@end
