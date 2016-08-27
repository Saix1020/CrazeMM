//
//  BaseProductDetailDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "DepotDTO.h"

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

@interface BaseProductLogDTO : BaseDTO

@property (nonatomic, copy) NSString* createTime;
@property (nonatomic, copy) NSString* message;
@property (nonatomic, copy) NSString* stateLabel;
@property (nonatomic) NSInteger afterState;
@property (nonatomic) NSInteger beforeState;
//@property (nonatomic) NSInteger sid;

-(instancetype)initWith:(NSDictionary *)dict;

@end

@interface BaseProductDetailDTO : BaseDTO
@property (nonatomic) BOOL isSplit;
@property (nonatomic) BOOL active;
@property (nonatomic) BOOL isSerial;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic) BOOL isTop;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) BOOL isBrushMachine;
@property (nonatomic) BOOL isStep;
@property (nonatomic) BOOL isAnoy;

@property (nonatomic, copy) NSString* deadlineStr;
@property (nonatomic, copy) NSString* message;
@property (nonatomic, copy) NSString* stateLabel;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic, copy) NSString* region;
@property (nonatomic, copy) NSString* goodImage; // mostly you should set it yourself

@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger millisecond;
@property (nonatomic) NSInteger intentions;
@property (nonatomic) NSInteger version;
@property (nonatomic) NSInteger duration;
@property (nonatomic) NSInteger left;
@property (nonatomic) NSInteger state;
@property (nonatomic) NSInteger views;

@property (nonatomic) CGFloat price;

@property (nonatomic, strong) ProductUserInfo* users;
@property (nonatomic, strong) NSDictionary* stock;
@property (nonatomic, strong) DepotDTO* depotDto;

@property (nonatomic, strong) NSMutableArray<ProductStepPrice*>* stepPrices;
@property (nonatomic, strong) NSMutableArray* logs;

-(CGFloat)totalPriceWithAmount:(NSInteger)amount;


@end
