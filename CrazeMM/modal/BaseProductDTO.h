//
//  BaseProductDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "BaseProductDetailDTO.h"
#import "DepotDTO.h"

@interface BaseProductDTO : BaseDTO

//isAnoy": false,

//"goodImage": "http:\/\/www.189mm.com:8080\/upload\/good\/1666.png?_=1a87e118502ad52c2f84bbef380e968b",
//"deadlineStr": "72小时以上",
//"millisecond": -142904691,
//"isSerial": true,
//"duration": 24,
//"goodName": "苹果-iPhone SE 粉 16G 全网通",
//"price": 1900.00,
//"isOriginalBox": true,
//"id": 2029,
//"state": 100,
//"stock": false,
//"isBrushMachine": false,
//"views": 9,
//"isSplit": true,
//"quantity": 100,
//"active": false,
//"intentions": 2,
//"message": null,
//"version": 2,
//"isOriginal": true,
//"left": 98,
//"createTime": "2016-06-27 21:18:12",
//"isTop": true,
//"stateLabel": "在售",
//"stepPrices": [{
//    "qfrom": 0,
//    "sprice": 2000,
//    "qto": 50,
//    "sid": 2029
//}, {
//    "qfrom": 50,
//    "sprice": 1900,
//    "qto": 100,
//    "sid": 2029
//}],
//"region": "不限",
//"user": {
//    "typeName": "个人",
//    "successOrderCount": 25,
//    "id": 389,
//    "validateState": 300,
//    "username": "楚楚"
//},
//"isStep": true


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
