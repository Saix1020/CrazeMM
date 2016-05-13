//
//  HttpOrder.m
//  CrazeMM
//
//  Created by saix on 16/5/7.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpOrder.h"

@implementation HttpOrderRequest


-(instancetype)initWithOrderListType:(MMOrderListStyle)type andPage:(NSUInteger)pn
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"t" : type.orderType==kOrderTypeBuy? @"b" : @"s",
                         @"pn" : @(pn),
                         @"state" : @(type.orderState)
                        } mutableCopy];
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

-(void)parserResponse
{
    if (!self.all) {
        return;
    }
    self.orderDetailDTOs = [[NSMutableArray alloc] init];
    
    if (!self.orderLists) {
        return;
    }
    for (NSDictionary* dict in self.orderLists) {
        OrderDetailDTO* dto = [[OrderDetailDTO alloc] initWithOrderDetail:dict];
        NSLog(@"%@", dto);
        [self.orderDetailDTOs  addObject:dto];
    }
}

-(NSDictionary*)page
{
    if (self.all) {
        id page = self.all[@"page"];
        if ([page isKindOfClass:[NSNull class]]) {
            return nil;
        }
        return self.all[@"page"];
    }
    return nil;
}

-(NSUInteger)pageNumber
{
    if (self.all && self.page) {
        NSNumber* number = self.all[@"page"][@"pageNumber"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalPage
{
    
    if (self.all && self.page) {
        NSNumber* number = self.all[@"page"][@"totalPage"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSUInteger)totalRow
{
    if (self.all && self.page) {
        NSNumber* number = self.all[@"page"][@"totalRow"];
        return [number integerValue];
    }
    
    return 0;
}

-(NSArray*)orderLists
{
    if (self.all && self.page) {
        NSArray* orderLists = self.all[@"page"][@"list"];
        return orderLists;
    }
    
    return @[];
}


@end