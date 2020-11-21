//
//  PayDetailDTO.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/15.
//  Copyright © 2016年 189. All rights reserved.
//

#import "PayInfoDTO.h"

@implementation PayInfoDTO

-(instancetype)initWith:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.orignalData = dict;
        self.PAYMENT = [dict[@"PAYMENT"] floatValue];
        self.TYPE = [dict[@"TYPE"] integerValue];
        self.GATEWAY = dict[@"GATEWAY"];
        self.MERCHANTID = dict[@"MERCHANTID"];
        self.POSID = dict[@"POSID"];
        self.REMARK1 = dict[@"REMARK1"];
        self.REMARK2 = dict[@"REMARK2"];
        self.MAC = dict[@"MAC"];
        self.ORDERID = dict[@"ORDERID"];
        self.CLIENTIP = dict[@"CLIENTIP"];
        self.CURCODE = dict[@"CURCODE"];
        self.TIMEOUT = dict[@"TIMEOUT"];
        self.BRANCHID = dict[@"BRANCHID"];
        self.TXCODE = dict[@"TXCODE"];
    }

    return self;
}

-(NSString*)formUrlencodedString
{
    return [NSString stringWithFormat:
            @"MERCHANTID=%@"
            "&POSID=%@"
            "&BRANCHID=%@"
            "&ORDERID=%@"
            "&PAYMENT=%0.2f"
            "&CURCODE=%@"
            "&REMARK1=%@"
            "&REMARK2=%@"
            "&TXCODE=%@"
            "&MAC=%@"
            "&TYPE=%ld"
            "&TIMEOUT=%@"
            "&GATEWAY=%@"
            "&CLIENTIP=%@",
            self.MERCHANTID,
            self.POSID,
            self.BRANCHID,
            self.ORDERID,
            self.PAYMENT,
            self.CURCODE,
            self.REMARK1,
            self.REMARK2,
            self.TXCODE,
            self.MAC,
            self.TYPE,
            self.TIMEOUT,
            self.GATEWAY,
            self.CLIENTIP];
}

@end
