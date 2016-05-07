//
//  OrderDetailDTO.m
//  CrazeMM
//
//  Created by saix on 16/5/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "OrderDetailDTO.h"

@implementation OrderDetailDTO

//@property (nonatomic) BOOL isAony;
//@property (nonatomic) NSInteger quantity;
//@property (nonatomic, copy) NSString* userImage;
//@property (nonatomic, copy) NSString* goodName;
//@property (nonatomic) CGFloat price;
//@property (nonatomic, copy) NSString* updateTime;
//@property (nonatomic) MMOrderState state;
//@property (nonatomic, copy) NSString* userName;

-(instancetype)initWithOrderDetail:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.id = [dict[@"id"] integerValue];
        self.isAony = [dict[@"isAony"] boolValue];
        self.quantity = [dict[@"quantity"] integerValue];
        self.price = [dict[@"price"] floatValue];
        self.state = (MMOrderState)[dict[@"state"] integerValue];
        self.userImage = dict[@"userImage"];
        self.goodName = dict[@"goodName"];
        self.updateTime = dict[@"updateTime"];
        self.userName = dict[@"userName"];
        self.selected = YES;
    }
    return self;
}

@end
