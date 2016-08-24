//
//  MineUserInfoDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

//{"me":{"image":"4_cut.jpg","salt":"de7ca58a-dc3e-4078-b54a-741f0a62b432","mobile":"13776573631","recommend":false,"validateState":300,"type":0,"classification":1,"validateTime":"2015-03-18 09:17:28","cashFund":null,"password":"55ce12486d167cf60bca4a12cf68dd95","loginTime":"2016-06-24 16:41:15","validated":true,"createTime":"2014-07-09 00:36:53","invoiceNumber":3,"disabled":false,"id":4,"credit":null,"notifyAccept":true,"wx_id":1,"email":"zhoumoxuan@qq.com","username":"xuanxuan","notifyRemind":true},"ok":true}

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


@end
