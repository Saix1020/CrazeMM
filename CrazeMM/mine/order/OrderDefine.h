//
//  OrderDefine.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/7.
//  Copyright © 2016年 189. All rights reserved.
//

#ifndef OrderDefine_h
#define OrderDefine_h

typedef NS_ENUM(NSInteger, MMOrderType){
    kOrderTypeBuy = 0,
    kOrderTypeSupply = 1,
};
typedef NS_ENUM(NSInteger, MMOrderSubType){
    kOrderSubTypePay = 0,
    kOrderSubTypeReceived,
    kOrderSubTypeConfirmed,
    kOrderSubTypeSend,
    kOrderSubTypeAll
};

// Will this state code be changed?
typedef NS_ENUM(NSInteger, MMOrderState){
    COMPLETED = 500, //完成
    PAYTIMEOUT = 700, //支付超时
    TOBECONFIRMED = 401, //待确认
    TOBEPAID = 100, //待付款
    PAYING = 101,
    TOBERECEIVED = 300,//待签收
    TOBESENT = 200,// 待发货
    TOBESETTLED = 400, //待结款
    ORDERCLOSE = 600,
    
    // TOBEPAID -> TOBESENT(PAYCOMPLETE) -> TOBERECEIVED(SENTCOMPLETE) -> TOBESETTLED(RECEIVECOMPLETE) -> TOBECONFIRMED -> COMPLETED(CONFIRMEDCOMPLETE)
    WAITFORPAY = TOBEPAID,
    PAYCOMPLETE = TOBESENT,
    RECEIVECOMPLETE = TOBESETTLED,
    SENTCOMPLETE = TOBERECEIVED,
    CONFIRMEDCOMPLETE = COMPLETED,
};


typedef struct {
    MMOrderType orderType;
    MMOrderSubType orderSubType;
    MMOrderState orderState;
}MMOrderListStyle;

@interface  OrderDefine: NSObject

+(NSString*)orderStateToStringWithType:(MMOrderType)type andState:(MMOrderState)state;
@end

#endif /* OrderDefine_h */
