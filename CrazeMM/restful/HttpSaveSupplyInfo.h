//
//  HttpSaveSupplyInfo.h
//  CrazeMM
//
//  Created by saix on 16/5/19.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

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

@interface GoodCreateInfo : NSObject

@property (nonatomic) NSInteger id;
@property (nonatomic) NSInteger brand;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger deadline;
@property (nonatomic) NSInteger duration;
@property (nonatomic) CGFloat price;

@property (nonatomic, copy) NSString* color;
@property (nonatomic, copy) NSString* volume;
@property (nonatomic, copy) NSString* network;
@property (nonatomic) BOOL isSerial;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) BOOL isBrushMachine; //
@property (nonatomic) BOOL isSplit;
@property (nonatomic) BOOL isAnoy;



@end

@interface HttpSaveSupplyInfoRequest : BaseHttpRequest

-(instancetype)initWithGoodInfo:(GoodCreateInfo*)goodCreateInfo;

@end
