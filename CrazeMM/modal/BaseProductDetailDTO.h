//
//  BaseProductDetailDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"


@interface ProductUserInfo : BaseDTO
@property (nonatomic, copy) NSString* typeName;
@property (nonatomic) NSInteger validateState;
@property (nonatomic, copy) NSString* username;
@property (nonatomic) NSInteger successOrderCount;
@end

@interface ProductStepPrice : BaseDTO

@property (nonatomic) NSInteger qfrom;
@property (nonatomic) NSInteger qto;
@property (nonatomic) NSInteger sid;
@property (nonatomic) CGFloat sprice;

@end

@interface BaseProductDetailDTO : BaseDTO
@property (nonatomic) BOOL isSplit;
@property (nonatomic) NSInteger quantity;
@property (nonatomic, copy) NSString* deadlineStr;
@property (nonatomic) NSInteger millisecond;
@property (nonatomic) BOOL active;
@property (nonatomic) NSInteger intentions;
@property (nonatomic, copy) NSString* message;
@property (nonatomic) NSInteger version;
@property (nonatomic) BOOL isSerial;
@property (nonatomic) NSInteger duration;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic) NSInteger left;
@property (nonatomic) CGFloat price;
@property (nonatomic) BOOL isTop;
@property (nonatomic, copy) NSString* stateLabel;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) NSInteger state;
@property (nonatomic, copy) NSString* region;
@property (nonatomic) BOOL isBrushMachine;
@property (nonatomic, copy) NSString* goodImage; // mostly you should set it yourself

@property (nonatomic) BOOL isStep;
@property (nonatomic) NSInteger views;

@property (nonatomic, strong) ProductUserInfo* users;
@property (nonatomic, strong) NSMutableArray<ProductStepPrice*>* stepPrices;

@end
