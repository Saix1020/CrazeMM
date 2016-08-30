//
//  HttpPayRecord.m
//  CrazeMM
//
//  Created by Mao Mao on 16/8/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpPayRecord.h"
#import "PayRecordDTO.h"

#pragma mark - HttpPayRecord

@implementation HttpPayRecordRequest

-(instancetype)initWithPageNum:(NSInteger)pn andStatus:(NSInteger)status
{
    self = [super initWithPageNum:pn];
    if (self) {
        self.status = status;
        self.params[@"state"] = @(status);
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/pay/myPay");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpPayRecordResponse class];
}

@end

@implementation HttpPayRecordResponse

-(BaseListDTO*)makeDtoWith:(NSDictionary*)dict
{
    PayRecordDTO* dto = [[PayRecordDTO alloc] initWith:dict];
    return dto;
}

@end

#pragma mark - HttpPayRefresh

@implementation HttpPayRefreshRequest

-(instancetype)initWithPayNo:(NSInteger)payNo
{
    self = [super init];
    if (self)
    {
        self.payNo = payNo;
    }
    return self;
}

-(NSString*)url
{
    NSString* URL = [NSString stringWithFormat:@"/rest/pay/refresh/P%ld",self.payNo];
    return COMB_URL(URL);
}

-(NSString*)method
{
    return @"GET";
}

@end

#pragma mark - HttpPayCancel

@implementation HttpPayCancelRequest

-(instancetype)initWithPayNo:(NSInteger)payNo
{
    self = [super init];
    if (self)
    {
        self.payNo = payNo;
    }
    return self;
}

-(NSString*)url
{
    NSString* URL = [NSString stringWithFormat:@"/rest/pay/cancel/P%ld",self.payNo];
    return COMB_URL(URL);
}

-(NSString*)method
{
    return @"GET";
}

@end


#pragma mark - HttpPayData
@implementation HttpPayDataRequest

-(instancetype)initWithPayNo:(NSInteger)payNo
{
    self = [super init];
    if (self)
    {
        self.payNo = payNo;
    }
    return self;
}

-(NSString*)url
{
    NSString* URL = [NSString stringWithFormat:@"/rest/pay/data/P%ld",self.payNo];
    return COMB_URL(URL);
}

-(NSString*)method
{
    return @"GET";
}

-(Class) responseClass
{
    return [HttpPayDataResponse class];
}


@end

@implementation HttpPayDataResponse

-(void)parserResponse
{
    if (self.all && self.all[@"b2cData"]) {
        self.payInfoDto = [[PayInfoDTO alloc] initWith:self.all[@"b2cData"]];
    }
}

@end
