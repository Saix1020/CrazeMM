//
//  HttpPay.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpPay.h"

@implementation HttpPayInfoRequest

-(AFHTTPSessionManager*)manager
{
    AFHTTPSessionManager* manager = super.manager;
    [manager.requestSerializer setValue:@"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    return manager;
}


-(instancetype)initWithPayPrice:(CGFloat)price
{
    self = [super init];
    if (self) {
        self.params = [@{
                        @"t" : @(price)
                        } mutableCopy];
    }
    return self;
}

-(instancetype)initWithPayPrice:(CGFloat)price andTarget:(NSString*)target
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"t" : @(price),
                         @"target" : target
                         } mutableCopy];
    }
    return self;

}

-(NSString*)url
{
    return COMB_URL(@"/rest/order/payinfo");
}

-(NSString*)method{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpPayInfoResponse class];
}

@end

@implementation HttpPayInfoResponse

-(void)parserResponse
{
    if (self.all && self.all[@"pay"]) {
        self.payInfoDto = [[PayInfoDTO alloc] initWith:self.all[@"pay"]];
    }
}

@end



@implementation HttpPayRequest

-(instancetype)initWithPayNo:(NSString*)payNo andOrderId:(NSInteger)orders andAddrId:(NSInteger)addrId
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"payNo" : payNo,
                         @"orders": @(orders),
                         @"addrId": @(addrId)
                         } mutableCopy];
    }
    
    return self;
}
-(instancetype)initWithPayNo:(NSString*)payNo andMethod:(NSInteger)method andMoney:(CGFloat)money
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"no" : payNo,
                         @"method": @(method),
                         @"money": @(money)
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/pay");
}

-(NSString*)method
{
    return @"POST";
}

@end

@implementation HttpRechargeRequest

-(instancetype)initWithPayNo:(NSString*)payNo andMethod:(NSInteger)method andMoney:(CGFloat)money
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"no" : payNo,
                         @"method": @(method),
                         @"money": @(money)
                         } mutableCopy];
    }
    
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/recharge");
}

-(NSString*)method
{
    return @"POST";
}

@end

@implementation HttpPayResultRequest

-(instancetype)initWithPayNo:(NSString *)payNo
{
    self = [super init];
    if (self) {
        self.payNo = payNo;
    }
    
    return self;
}

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/pay/%@", self.payNo];
    return COMB_URL(absUrl);
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpPayResultResponse class];
}

@end

@implementation HttpPayResultResponse

-(NSString*)endTime
{
    return self.all[@"pay"][@"endTime"];
}

-(BOOL)procSuc
{
    return [self.all[@"pay"][@"procSuc"] integerValue] == 1;
}

-(BOOL)isSuc
{
    return [self.all[@"pay"][@"isSuc"] integerValue] == 1;
}

-(BOOL)paySuccess
{
    return NotNilAndNull(self.endTime) && self.procSuc && self.isSuc;
}

@end

@implementation HttpBlancePayRequest

-(instancetype)initWithAmount:(float)amount andOrders:(NSArray *)orders andPayPassword:(NSString *)payPassword andAddrId:(NSInteger)addrId
{
    
    self = [super init];
    if (self) {
        self.params = [@{
                         @"amount" : @(amount),
                         @"orders": [orders componentsJoinedByString:@","],
                         @"payPassword": payPassword,
                         @"addrId" : @(addrId)
                         } mutableCopy];
    }
    return self;
}

-(BOOL)needToken
{
    return YES;
}

-(NSString*)tokenName
{
    return @"balance_pay_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/balance/pay");
}

-(NSString*)method
{
    return @"POST";
}

-(Class)responseClass
{
    return [HttpBlancePayResponse class];
}

@end


@implementation HttpBlancePayResponse

-(void)parserResponse
{
    if (NotNilAndNull(self.all[@"stock"])) {
        self.stockDetailDtos = [[NSMutableArray alloc] init];
        NSArray* stocks = self.all[@"stock"];
        for (NSDictionary* stock in stocks) {
            StockDetailDTO* stockDetail = [[StockDetailDTO alloc] initWith:stock];
            [self.stockDetailDtos addObject:stockDetail];
        }
    }
}

@end
