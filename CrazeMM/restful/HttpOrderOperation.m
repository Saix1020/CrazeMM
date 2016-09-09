//
//  HttpOrderOperation.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrderOperation.h"

@implementation HttpBaseOrderOperationRequest

-(instancetype)initWithOid:(NSInteger)oid
{
    self = [super init];
    if (self) {
        //self.oid = oid;
        self.oids = [[NSMutableArray alloc] init];
        [self.oids addObject:@(oid)];
    }
    return self;
}

-(instancetype)initWithOids:(NSArray *)oids
{
    self = [super init];
    if (self) {
        //self.oid = oid;
        self.oids = [[NSMutableArray alloc] initWithArray:oids];
    }
    return self;
}

-(NSString*)method
{
    return @"GET";
}

@end


@implementation HttpOrderReactiveRequest

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/activate/%@", [self.oids componentsJoinedByString:@","]];
    return COMB_URL(absUrl);
}

@end

@implementation HttpOrderReceiveRequest

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/receive/%@",  [self.oids componentsJoinedByString:@","]];
    return COMB_URL(absUrl);
}

@end

@implementation HttpOrderSendRequest

-(instancetype)initWithOids:(NSArray *)oids andCheckoutMethod:(NSInteger)checkoutMethod andAccount:(NSInteger)account andLogisId:(NSInteger)logisId andLogisName:(NSString*)logisName andOrderCode:(NSString*)orderCode
{
    self = [super initWithOids:oids];
    //checkoutMethod:1
    //account:166
    //orderLogisId:3
    //logisName:
    //orderCode:7777777777777777

    if (self) {
        self.params = [@{
                         @"checkoutMethod" : @(checkoutMethod),
                         @"account" : @(account),
                         @"orderLogisId" : @(logisId),
                         @"logisName" : logisName,
                         @"orderCode" : orderCode
                         } mutableCopy];
    }
    
    return self;
}



-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/send/%@",  [self.oids componentsJoinedByString:@","]];
    return COMB_URL(absUrl);
}

-(NSString*)method
{
    return @"POST";
}

@end

@implementation HttpOrderConfirmRequest

-(NSString*)url
{
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/confirm/%@",  [self.oids componentsJoinedByString:@","]];
    return COMB_URL(absUrl);
}

@end

@implementation HttpOrderLogicDelete

-(NSString*)url
{
    // change /rest/order/logicDelete/%@ to /rest/order/logicDeleteByIds/%@
    NSString* absUrl = [NSString stringWithFormat:@"/rest/order/logicDeleteByIds/%@",  [self.oids componentsJoinedByString:@","]];
    return COMB_URL(absUrl);
}


@end