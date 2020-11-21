//
//  HttpPay.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "PayInfoDTO.h"
#import "StockDetailDTO.h"

@interface HttpPayInfoRequest : BaseHttpRequest

-(instancetype)initWithPayPrice:(CGFloat)price;
-(instancetype)initWithPayPrice:(CGFloat)price andTarget:(NSString*)target;

@end

@interface HttpPayInfoResponse : BaseHttpResponse

@property (nonatomic, strong) PayInfoDTO* payInfoDto;

@end


@interface HttpPayRequest : BaseHttpRequest
//payNo:P160522500404484
//orders:1079
//addrId:183
-(instancetype)initWithPayNo:(NSString*)payNo andOrderId:(NSInteger)orders andAddrId:(NSInteger)addrId;
@end

@interface HttpRechargeRequest : BaseHttpRequest
-(instancetype)initWithPayNo:(NSString*)payNo andMethod:(NSInteger)method andMoney:(CGFloat)money;
@end

@interface HttpPayResultRequest : BaseHttpRequest

@property (nonatomic, copy) NSString* payNo;

-(instancetype)initWithPayNo:(NSString*)payNo;

@end

@interface HttpPayResultResponse : BaseHttpResponse
//{"pay":{"total":2000.00,"createTime":"2016-05-22 14:16:52","procSuc":true,"isSuc":true,"id":116,"endTime":"2016-05-22 14:17:52"},"ok":true}
@property (nonatomic, readonly) NSString* endTime;
@property (nonatomic, readonly) BOOL procSuc;
@property (nonatomic, readonly) BOOL isSuc;
@property (nonatomic, readonly) BOOL paySuccess;
@end


// blance pay
// http://b.189mm.com/rest/token?name=balance_pay_token
//http://b.189mm.com/rest/balance/pay post
//    amount	4476
//    orders	1281
//    payPassword	111111
//    balance_pay_token	8411554032545728222

//    {
//        "ok": true,
//        "stock": [{
//            "gid": 1670,
//            "inprice": 1119.00,
//            "depotId": 5,
//            "updateTime": "2016-06-26",
//            "gvolume": "16G",
//            "presale": 4,
//            "version": 0,
//            "isSerial": true,
//            "isOriginal": true,
//            "uid": 4,
//            "goodName": "华硕-飞马X003 黑 16G 电信版",
//            "gcolor": "黑",
//            "isOriginalBox": true,
//            "id": 109,
//            "gnetwork": "电信版",
//            "isBrushMachine": false
//        }]
//    }


@interface HttpBlancePayRequest : BaseHttpRequest

-(instancetype)initWithAmount:(float)amount andOrders:(NSArray *)orders andPayPassword:(NSString *)payPassword andAddrId:(NSInteger)addrId;


@end

@interface HttpBlancePayResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray* stockDetailDtos;

@end
