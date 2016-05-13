//
//  HttpOrderStatus.h
//  CrazeMM
//
//  Created by saix on 16/5/12.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "OrderDefine.h"
#import "OrderStatusDTO.h"

@interface HttpOrderStatusRequest : BaseHttpRequest

@property (nonatomic) NSInteger orderId;

-(instancetype)initWithOrderId:(NSInteger)orderId andOderType:(MMOrderType)orderType;

@end

@interface HttpOrderStatusResponse : BaseHttpResponse
//{"ok":true,"order":{"isAnoy":false,"quantity":1,"userImage":"http:\/\/www.189mm.com:8080\/upload\/user\/109_cut.jpg","goodName":"苹果-iPhone 6S 金 16G 全网通","price":5555.00,"updateTime":"2015-11-16 09:36:28","id":681,"state":100,"userName":"liufuzhi","addr":{"uid":4,"zipCode":"210000","isDefault":false,"phone":null,"street":"山西路68号27FAB座","contact":"周墨宣","mobile":"15301598286","pid":16,"id":17,"region":"江苏-南京-鼓楼区","did":1835,"cid":220},"logs":[{"uid":4,"createTime":"2015-11-16 09:36:28","oldState":0,"comment":"保存购买订单","id":1815,"oid":681,"userName":"xuanxuan","newStateLabel":"待付款","newState":100}]}}
@property (nonatomic, readonly) NSDictionary* order;
@property (nonatomic, strong) OrderStatusDTO* orderStatusDto;
@end;