//
//  HttpSupplyOrder.h
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpSupplyOrderRequest : BaseHttpRequest

-(instancetype)initWithSid:(NSInteger)sid andVersion:(NSInteger)version andQuantity:(NSInteger)quantity andMessage:(NSString*)message;

@end

@interface HttpSupplyOrderResponse : BaseHttpResponse

@property (nonatomic, readonly) NSInteger orderId;
@property (nonatomic, readonly) CGFloat price;
@property (nonatomic, readonly) NSInteger quantity;

@end
