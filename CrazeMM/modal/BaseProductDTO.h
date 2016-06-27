//
//  BaseProductDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "BaseProductDetailDTO.h"
#import "DepotDTO.h"

@interface BaseProductDTO : BaseDTO

@property (nonatomic, copy) NSString* deadlineStr;
@property (nonatomic) NSInteger duration;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic) NSInteger intentions;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isAnoy;
@property (nonatomic) BOOL isStep;
@property (nonatomic) BOOL isBrushMachine;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) BOOL isSerial;
@property (nonatomic) NSInteger millisecond;
@property (nonatomic) CGFloat price;
@property (nonatomic) NSInteger quantity;
@property (nonatomic, copy) NSString* region;
@property (nonatomic, copy) NSString* address;
@property (nonatomic, copy) NSString* stateLabel;
@property (nonatomic, copy) NSString* userImage;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic) NSInteger views;


@property (nonatomic, strong) NSString* createTime;
@property (nonatomic, strong) NSString* goodImage;
@property (nonatomic) BOOL selected;

@property (nonatomic, strong) NSDictionary* stock;
@property (nonatomic, strong) DepotDTO* depotDto;

-(instancetype)initWith:(NSDictionary*)dict;

-(void)resetByProductDetailDto:(BaseProductDetailDTO*)detailDto;

@end
