//
//  HttpOrder.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrder.h"

@implementation HttpOrderRequest


-(instancetype)initWithOrderListType:(MMOrderListStyle)type andPage:(NSUInteger)pn
{
    self = [super init];
    if (self) {
        NSString* orderStatus;
        if (type.orderState == TOBESETTLED) {
            orderStatus = [NSString stringWithFormat:@"%ld,%u,%u", TOBESETTLED, 401u, 500u];
        }
        else {
            orderStatus = [NSString stringWithFormat:@"%ld", type.orderState];

        }
        
        self.params = [@{
                         @"t" : type.orderType==kOrderTypeBuy? @"b" : @"s",
                         @"pn" : @(pn),
                         @"state" : orderStatus
                        } mutableCopy];
    }
    return self;
}

-(instancetype)initWithOrderListType:(MMOrderListStyle)type andPage:(NSUInteger)pn andConditions:(NSDictionary*)conditions
{
    self = [self initWithOrderListType:type andPage:pn];
    if (self) {
        [self.params addEntriesFromDictionary:conditions];
    }
    
    return self;
}


-(NSString*)url
{
    return COMB_URL(@"/rest/order");
    
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpOrderResponse class];
}



@end

@implementation HttpOrderResponse

//@property (nonatomic, readonly) NSDictionary* page;
//@property (nonatomic, readonly) NSArray* list;
//@property (nonatomic, readonly) NSInteger pageNumber;
//@property (nonatomic, readonly) NSInteger pageSize;
//@property (nonatomic, readonly) NSInteger totalPage;
//@property (nonatomic, readonly) NSInteger totalRow;

-(instancetype)initWith:(NSDictionary *)response
{
    self = [super initWith:response];
    if (self) {
        [self parserResponse];
    }
    return self;
}
-(BaseListDTO*)makeDtoWith:(NSDictionary*)dict
{
    return [[OrderDetailDTO alloc] initWithOrderDetail:dict];
}

-(NSArray*)orderDetailDTOs
{
    return self.dtos;
}

//-(void)parserResponse
//{
//    if (!self.all) {
//        return;
//    }
//    self.orderDetailDTOs = [[NSMutableArray alloc] init];
//    
//    if (!self.orderLists) {
//        return;
//    }
//    for (NSDictionary* dict in self.orderLists) {
//        OrderDetailDTO* dto = [[OrderDetailDTO alloc] initWithOrderDetail:dict];
//        NSLog(@"%@", dto);
//        [self.orderDetailDTOs  addObject:dto];
//    }
//}

//-(NSDictionary*)page
//{
//    if (self.all) {
//        id page = self.all[@"page"];
//        if ([page isKindOfClass:[NSNull class]]) {
//            return nil;
//        }
//        return self.all[@"page"];
//    }
//    return nil;
//}
//
//-(NSUInteger)pageNumber
//{
//    if (self.all && self.page) {
//        NSNumber* number = self.all[@"page"][@"pageNumber"];
//        return [number integerValue];
//    }
//    
//    return 0;
//}
//
//-(NSUInteger)totalPage
//{
//    
//    if (self.all && self.page) {
//        NSNumber* number = self.all[@"page"][@"totalPage"];
//        return [number integerValue];
//    }
//    
//    return 0;
//}
//
//-(NSUInteger)totalRow
//{
//    if (self.all && self.page) {
//        NSNumber* number = self.all[@"page"][@"totalRow"];
//        return [number integerValue];
//    }
//    
//    return 0;
//}
//
//-(NSArray*)orderLists
//{
//    if (self.all && self.page) {
//        NSArray* orderLists = self.all[@"page"][@"list"];
//        return orderLists;
//    }
//    
//    return @[];
//}


@end

@implementation HttpAllBuyOrderRequest

-(instancetype)initWithPage:(NSInteger)pn
{
    MMOrderListStyle style = {
        .orderType = kOrderTypeBuy
    };
    self = [super initWithOrderListType:style andPage:pn];
    if (self) {
        self.params[@"state"] = @"all";
        self.params[@"t"] = @"b";
    }
    
    return self;
}

-(instancetype)initWithPage:(NSInteger)pn andConditions:(NSDictionary *)conditions
{
    self = [self initWithPage:pn];
    [self.params addEntriesFromDictionary:conditions];
    return self;
}

@end

@implementation HttpAllSupplyOrderRequest

-(instancetype)initWithPage:(NSInteger)pn
{
    MMOrderListStyle style = {
        .orderType = kOrderTypeBuy
    };
    self = [super initWithOrderListType:style andPage:pn];
    if (self) {
        self.params[@"state"] = @"all";
        self.params[@"t"] = @"s";
    }
    
    return self;
}

-(instancetype)initWithPage:(NSInteger)pn andConditions:(NSDictionary *)conditions
{
    self = [self initWithPage:pn];
    [self.params addEntriesFromDictionary:conditions];
    return self;
}


@end
