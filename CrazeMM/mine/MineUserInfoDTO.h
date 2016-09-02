//
//  MineUserInfoDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

//{
//    "me": {
//        "addrCname": "上海",
//        "companyName": "上海卓瓦实业有限公司",
//        "recommend": false,
//        "validateState": 300,
//        "type": 1,
//        "addrPid": 25,
//        "head": "沈振华",
//        "addrStreet": "天目西路188号816",
//        "password": "4de890a741addb86aa6dd97634f76e6d",
//        "loginTime": "2016-09-02 12:40:47",
//        "validated": true,
//        "identity": "310229194912011410",
//        "invoiceNumber": null,
//        "addrDid": 2704,
//        "disabled": false,
//        "addrCid": 321,
//        "id": 56,
//        "credit": null,
//        "notifyAccept": true,
//        "email": "undeadboy@126.com",
//        "image": null,
//        "salt": "7269365c87864e1f9a24188c2d9bbd38",
//        "sex": "男",
//        "mobile": "12345678901",
//        "classification": 1,
//        "validateTime": "2015-03-31 15:34:40",
//        "cashFund": null,
//        "addrDname": "闸北区",
//        "createTime": "2015-01-30 13:53:51",
//        "addrPname": "上海",
//        "wx_id": null,
//        "username": "上海卓瓦实业有限公司",
//        "notifyRemind": true
//    },
//    "ok": true
//}


@interface MineUserInfoDTO : BaseDTO

@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* salt;
@property (nonatomic, copy) NSString* mobile;
@property (nonatomic, copy) NSString* validateTime;
@property (nonatomic, copy) NSString* loginTime;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* createTime;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* username;

@property (nonatomic) BOOL recommend;
@property (nonatomic) BOOL validated;
@property (nonatomic) BOOL disabled;
@property (nonatomic) BOOL notifyAccept;
@property (nonatomic) BOOL notifyRemind;

@property (nonatomic) NSInteger validateState;
@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger classification;
@property (nonatomic) NSInteger invoiceNumber;
@property (nonatomic) NSInteger wx_id;

@property (nonatomic, copy) NSString* companyName;
@property (nonatomic, copy) NSString* head;
@property (nonatomic, copy) NSString* sex;
@property (nonatomic, copy) NSString* identity;

@property (nonatomic) NSInteger addrPid;
@property (nonatomic) NSInteger addrCid;
@property (nonatomic) NSInteger addrDid;

@property (nonatomic, copy) NSString* addrPname;
@property (nonatomic, copy) NSString* addrCname;
@property (nonatomic, copy) NSString* addrDname;
@property (nonatomic, copy) NSString* addrStreet;

@property (nonatomic, copy) NSString* realName;
@property (nonatomic, copy) NSString* qq;
@property (nonatomic, copy) NSString* weixin;


@end
