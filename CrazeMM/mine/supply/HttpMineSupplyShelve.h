//
//  HttpMineSupplyUnshelve.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/16.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpMineSupplyReshelveRequest : BaseHttpRequest

-(instancetype)initWithIds:(NSArray*)ids;


@end

@interface HttpMineSupplyUnshelveRequest : BaseHttpRequest

-(instancetype)initWithIds:(NSArray*)ids;


@end

@interface HttpMineBuyReshelveRequest : HttpMineSupplyReshelveRequest



@end

@interface HttpMineBuyUnshelveRequest : HttpMineSupplyUnshelveRequest



@end