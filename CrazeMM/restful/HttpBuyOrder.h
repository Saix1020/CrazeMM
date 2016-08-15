//
//  HttpBuyOrder.h
//  CrazeMM
//
//  Created by saix on 16/5/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpBuyOrderRequest : BaseHttpRequest

-(instancetype)initWithBid:(NSInteger)bid andQuantity:(NSInteger)quantity andMessage:(NSString*)msg;



@end
