//
//  HttpSaveSupplyInfo.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "GoodCreateInfo.h"
//gbrand:28
//supply.gid:1670
//supply.gcolor:黑
//supply.gvolume:16G
//supply.gnetwork:电信版
//supply.isSerial:true
//supply.isOriginal:true
//supply.isOriginalBox:true
//supply.isBrushMachine:true
//supply.price:1000
//supply.quantity:35
//supply.deadline:-1
//supply.duration:24
//supply.isSplit:true
//supply.isAnoy:true
////supply.duration:24



@interface HttpSaveSupplyInfoRequest : BaseHttpRequest

-(instancetype)initWithGoodInfo:(GoodCreateInfo*)goodCreateInfo;

@end

@interface HttpSaveBuyInfoRequest : BaseHttpRequest

-(instancetype)initWithGoodInfo:(GoodCreateInfo*)goodCreateInfo;

@end
