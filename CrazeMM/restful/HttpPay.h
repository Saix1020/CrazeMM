//
//  HttpPay.h
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "PayInfoDTO.h"

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
