//
//  PayDetailDTO.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"

@interface PayInfoDTO : BaseDTO

//{"pay":{"PAYMENT":"10000.00","GATEWAY":"UnionPay","MERCHANTID":"105320157340016","POSID":"562340452","REMARK1":"","REMARK2":"","MAC":"b5e354fac7146e5de4afed4f2b445101","ORDERID":"P160515496768734","CLIENTIP":"49.77.247.118","CURCODE":"01","TYPE":1,"BRANCHID":"320000000","TXCODE":"520100"},"ok":true}

@property (nonatomic) CGFloat PAYMENT;
@property (nonatomic, copy) NSString* GATEWAY;
@property (nonatomic, copy) NSString* MERCHANTID;
@property (nonatomic, copy) NSString* POSID;
@property (nonatomic, copy) NSString* REMARK1;
@property (nonatomic, copy) NSString* REMARK2;
@property (nonatomic, copy) NSString* MAC;
@property (nonatomic, copy) NSString* ORDERID;
@property (nonatomic, copy) NSString* CLIENTIP;
@property (nonatomic, copy) NSString* CURCODE;
@property (nonatomic, copy) NSString* BRANCHID;
@property (nonatomic) NSInteger TYPE;
@property (nonatomic, copy) NSString* TXCODE;

-(instancetype)initWith:(NSDictionary *)dict;
-(NSString*)formUrlencodedString;

@property (nonatomic, strong) NSDictionary* orignalData;

@end
