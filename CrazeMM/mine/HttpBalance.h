//
//  HttpBalance.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "BalanceDTO.h"

@interface HttpBalanceRequest : BaseHttpRequest

@end

@interface HttpBalanceResponse : BaseHttpResponse

@property (nonatomic, strong) BalanceDTO* balanceDto;

@end


//{"page":{"totalRow":10,"pageNumber":1,"totalPage":1,"pageSize":10,"list":[{"buid":4,"balanceOrderId":0,"afterMoney":747494.00,"message":"账户提现，提现记录ID：10","type":null,"amountOfMoney":1.00,"uid":4,"createTime":"2016-06-12 11:12:49","afterFreezeMoney":6.00,"beforeFreezeMoney":5.00,"id":133,"state":200,"beforeMoney":747495.00},{"buid":4,"balanceOrderId":0,"afterMoney":747495.00,"message":"账户提现，提现记录ID：9","type":null,"amountOfMoney":1.00,"uid":4,"createTime":"2016-06-12 11:12:31","afterFreezeMoney":5.00,"beforeFreezeMoney":4.00,"id":132,"state":200,"beforeMoney":747496.00},{"buid":4,"balanceOrderId":0,"afterMoney":747496.00,"message":"账户提现，提现记录ID：8","type":null,"amountOfMoney":1.00,"uid":4,"createTime":"2016-06-12 11:12:12","afterFreezeMoney":4.00,"beforeFreezeMoney":3.00,"id":131,"state":200,"beforeMoney":747497.00},{"buid":4,"balanceOrderId":0,"afterMoney":747497.00,"message":"账户提现，提现记录ID：7","type":null,"amountOfMoney":1.00,"uid":4,"createTime":"2016-06-12 11:05:20","afterFreezeMoney":3.00,"beforeFreezeMoney":2.00,"id":130,"state":200,"beforeMoney":747498.00},{"buid":4,"balanceOrderId":0,"afterMoney":747498.00,"message":"账户提现，提现记录ID：6","type":null,"amountOfMoney":1.00,"uid":4,"createTime":"2016-06-12 10:59:48","afterFreezeMoney":2.00,"beforeFreezeMoney":1.00,"id":129,"state":200,"beforeMoney":747499.00},{"buid":4,"balanceOrderId":0,"afterMoney":747499.00,"message":"账户提现，提现记录ID：5","type":null,"amountOfMoney":1.00,"uid":4,"createTime":"2016-06-10 10:35:34","afterFreezeMoney":1.00,"beforeFreezeMoney":0.00,"id":128,"state":200,"beforeMoney":747500.00},{"buid":4,"balanceOrderId":0,"afterMoney":1252500.00,"message":"订单[1165]支付成功, 货款转出账户","type":null,"amountOfMoney":252500.00,"uid":4,"createTime":"2016-06-05 22:06:11","afterFreezeMoney":0.00,"beforeFreezeMoney":0.00,"id":94,"state":200,"beforeMoney":1000000.00},{"buid":4,"balanceOrderId":0,"afterMoney":1000000.00,"message":"订单1164签收，冻结金额转到可用金额","type":null,"amountOfMoney":1000000.00,"uid":1,"createTime":"2016-06-05 21:58:23","afterFreezeMoney":0.00,"beforeFreezeMoney":1000000.00,"id":92,"state":200,"beforeMoney":0.00},{"buid":4,"balanceOrderId":0,"afterMoney":0.00,"message":"订单[1164]发货，货款转入冻结金额","type":null,"amountOfMoney":1000000.00,"uid":4,"createTime":"2016-06-05 21:57:51","afterFreezeMoney":1000000.00,"beforeFreezeMoney":0.00,"id":91,"state":200,"beforeMoney":0.00},{"buid":4,"balanceOrderId":0,"afterMoney":0.00,"message":"初始化账户","type":null,"amountOfMoney":0.00,"uid":4,"createTime":"2016-06-05 20:57:53","afterFreezeMoney":0.00,"beforeFreezeMoney":0.00,"id":88,"state":200,"beforeMoney":0.00}]},"ok":true}
@interface HttpBalanceLogRequest : BaseHttpRequest

-(instancetype)initWithPageNum:(NSInteger)pn;

@end

@interface HttpBalanceLogResponse : BaseHttpResponse

@property (nonatomic) NSInteger totalRow;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger pageSize;
@property (nonatomic, readonly) NSDictionary* page;

@property (nonatomic, strong) NSMutableArray* balanceLogDtos;
@end


@interface HttpBalanceValidatePwdRequest : BaseHttpRequest

-(instancetype)initWithOrignalPassword:(NSString*)orignalPassword;

@end

@interface HttpBalanceModifyPayPwdRequest : BaseHttpRequest

-(instancetype)initWithOrignalPassword:(NSString*)oPasswd andNewPassword:(NSString*)nPasswd andConfirmPassword:(NSString*)cPassword;
-(instancetype)initWithCaptchaMobile:(NSString*)captchaMobile andNewPassword:(NSString*)nPasswd andConfirmPassword:(NSString*)cPassword;

@end

@interface HttpBalanceValidateCodeRequest : BaseHttpRequest

-(instancetype)initWithVCode:(NSString*)vcode;

@end

