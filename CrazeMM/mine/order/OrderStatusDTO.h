//
//  OrderStatusDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "AddrDTO.h"
#import "DepotDTO.h"

@interface OrderLogDTO : BaseLogDTO


@property (nonatomic, copy) NSString* comment;
@property (nonatomic, copy) NSString* userName;
//@property (nonatomic, copy) NSString* newStateLabel;


@end


//{
//    "isAnoy": false,
//    "supplyName": "189mm",
//    "quantity": 1,
//    "goodImage": "http:\/\/www.189mm.com:8080\/upload\/good\/1732.jpg",
//    "updateTime": "2016-06-29 09:43:14",
//    "userName": "189mm",
//    "isSerial": true,
//    "isOriginal": true,
//    "userImage": "http:\/\/www.189mm.com:8080\/upload\/user\/1_cut.jpg",
//    "goodName": "锤子-AAAA DV 43 FDD",
//    "supplyMobile": "13776573631",
//    "price": 800.00,
//    "supplyEmail": "nuaazy@hotmail.com",
//    "isOriginalBox": true,
//    "stateLabel": "待付款",
//    "addrId": null,
//    "id": 1333,
//    "state": 100,
//    "stock": {
//        "gid": 1732,
//        "depot": {
//            "name": "良晋栖霞区仓库",
//            "id": 6,
//            "info": "良晋栖霞区仓库"
//        },
//        "inprice": 1000,
//        "depotId": 6,
//        "updateTime": "2016-06-29 09:12:49",
//        "presale": 0,
//        "aftersale": 0,
//        "gvolume": "43",
//        "version": 1,
//        "outstock": 0,
//        "isSerial": true,
//        "uid": 1,
//        "isOriginal": true,
//        "afterout": 0,
//        "gcolor": "DV",
//        "inmortgage": 1,
//        "isOriginalBox": true,
//        "id": 138,
//        "state": 200,
//        "insale": 0,
//        "gnetwork": "FDD",
//        "isBrushMachine": false
//    },
//    "isBrushMachine": false,
//    "logs": [{
//        "uid": 4,
//        "createTime": "2016-06-29 09:43:14",
//        "oldState": 0,
//        "comment": "保存买货订单",
//        "id": 4514,
//        "oid": 1333,
//        "userName": "xuanxuan",
//        "newStateLabel": "待付款",
//        "newState": 100,
//        "username": "xuanxuan"
//    }]

@interface OrderStatusDTO : BaseDTO

@property (nonatomic) BOOL isAnoy;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) NSInteger state;
@property (nonatomic, copy) NSString* userImage;

@property (nonatomic, copy) NSString* supplyName;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic, copy) NSString* goodImage;

@property (nonatomic, copy) NSString* updateTime;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic) CGFloat price;

@property (nonatomic, strong) AddrDTO* addr;
@property (nonatomic, strong) NSMutableArray<OrderLogDTO*>* logs;

@property (nonatomic, copy) NSDictionary* stock;
@property (nonatomic, strong) DepotDTO* depot;

@property (nonatomic, strong) NSString* lastPayNo;

@end


