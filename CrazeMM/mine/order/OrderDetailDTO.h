//
//  OrderDetailDTO.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseDTO.h"
#import "OrderDefine.h"
#import "HttpOrder.h"
#import "OrderStatusDTO.h"
#import "DepotDTO.h"
//"isAnoy":false, //是否匿名供货，匿名进不显示供货人/求购人信息
//"quantity":10, //供货数量
//"userImage":"http:\/\/www.189mm.com:8080\/upload\/user\/1_cut.jpg", //供货人/求购人图片
//"goodName":"华为-荣耀4A 黑 8G 全网通",//手机名称
//"price":1.00, //价格
//"updateTime":"2016-05-05 22:15:43", //更新时间
//"id":842, // 订单流水号
//"state":100, //状态
//"userName":"189mm" //供货人/求购人用户名

@class WaitForPayCell;

@interface OrderDetailDTO : BaseDTO

@property (nonatomic) BOOL isAony;
@property (nonatomic) NSInteger quantity;
@property (nonatomic, copy) NSString* userImage;
@property (nonatomic, copy) NSString* goodName;
@property (nonatomic, copy) NSString* goodImage;
@property (nonatomic) CGFloat price;
@property (nonatomic, copy) NSString* updateTime;
@property (nonatomic) MMOrderState state;
@property (nonatomic, copy) NSString* userName;

@property (nonatomic) BOOL isBrushMachine;
@property (nonatomic) BOOL isOriginal;
@property (nonatomic) BOOL isOriginalBox;
@property (nonatomic) BOOL isSerial;

@property (nonatomic, copy) NSString* stateLabel;

@property (nonatomic, copy) NSDictionary* stock;
@property (nonatomic, strong) DepotDTO* depotDto;

@property (nonatomic) BOOL selected;

-(instancetype)initWithOrderDetail:(NSDictionary*)dict;
-(instancetype)initWithOrderStatusDTO:(OrderStatusDTO*)statusDto;


@end



