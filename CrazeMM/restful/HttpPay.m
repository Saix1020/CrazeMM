//
//  HttpPay.m
//  CrazeMM
//
//  Created by saix on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpPay.h"

@implementation HttpPayInfoRequest

-(AFHTTPRequestOperationManager*)manager
{
    AFHTTPRequestOperationManager* manager = super.manager;
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

-(AFHTTPRequestOperationManager*)manager
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
//    [manager.requestSerializer setValue:COMB_URL(@"") forHTTPHeaderField:@"\"Origin\""];
//    [manager.requestSerializer setValue:COMB_URL(@"") forHTTPHeaderField:@"\"Referer\""];
//
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    return manager;
}

-(instancetype)initWithPayDetail:(PayInfoDTO*)payInfoDto
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"MERCHANTID" : payInfoDto.MERCHANTID,
                             @"POSID" :  payInfoDto.POSID,
                             @"BRANCHID" :  payInfoDto.BRANCHID,
                             @"ORDERID" :  payInfoDto.ORDERID,
                             @"PAYMENT" :  @(payInfoDto.PAYMENT),
                             @"CURCODE" :  payInfoDto.CURCODE,
                             @"REMARK1" :  payInfoDto.REMARK1,
                             @"REMARK2" :  payInfoDto.REMARK2,
                             @"TXCODE" :  payInfoDto.TXCODE,
                             @"TYPE" :  @(payInfoDto.TYPE),
                             @"GATEWAY" :  payInfoDto.GATEWAY,
                             @"CLIENTIP" : payInfoDto.CLIENTIP,
                        } mutableCopy];
    }
    return self;
}


-(NSString*)url
{
        return @"https://ibsbjstar.ccb.com.cn/app/ccbMain";
}

-(NSString*)method
{
    return @"POST";
}

@end
