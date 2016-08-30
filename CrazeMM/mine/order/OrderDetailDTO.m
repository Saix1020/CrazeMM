//
//  OrderDetailDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/7.
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
        self.goodImage = dict[@"goodImage"];
        self.updateTime = dict[@"updateTime"];
        self.userName = dict[@"userName"];
        
        self.isBrushMachine = [dict[@"isBrushMachine"] integerValue] == 1;
        self.isOriginal = [dict[@"isOriginal"] integerValue] == 1;
        self.isOriginalBox = [dict[@"isOriginalBox"] integerValue] == 1;
        self.isSerial = [dict[@"isSerial"] integerValue] == 1;
        
        self.stateLabel = dict[@"stateLabel"];
        
        if ([dict[@"stock"] isKindOfClass:[NSNumber class]]) {
            self.stock = nil;
        }
        else {
            self.stock = dict[@"stock"];
        }
        
        if (NotNilAndNull(dict[@"depot"])) {
            self.depotDto = [[DepotDTO alloc] initWith:dict[@"depot"]];
        }
        
        else if (NotNilAndNull(self.stock)) {
            self.depotDto = [[DepotDTO alloc] initWith:self.stock[@"depot"]];
        }

        
        self.selected = NO;
    }
    return self;
}

-(instancetype)initWithOrderStatusDTO:(OrderStatusDTO*)statusDto
{
    self = [self init];
    if (self) {
        self.id = statusDto.id;
        self.isAony = statusDto.isAnoy;
        self.quantity = statusDto.quantity;
        self.price = statusDto.price;
        self.state = statusDto.state;
        self.userImage = statusDto.userImage;
        self.goodName = statusDto.goodName;
        self.goodImage = statusDto.goodImage;
        self.updateTime = statusDto.updateTime;
        self.userName = statusDto.userName;
        self.stock = statusDto.stock;
        self.depotDto = statusDto.depot;
        self.selected = NO;
    }
    return self;
}

-(float)totalPrice
{
    return self.price * self.quantity;
}

@end
