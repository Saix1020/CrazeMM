//
//  HttpListQuery.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpListQuery.h"

@implementation HttpListQueryRequest

-(instancetype)initWith:(NSInteger)pn
{
    return [self initWithPageNum:pn];
}

-(instancetype)initWithPageNum:(NSInteger)pn
{
    self = [super init];
    if (self) {
        self.pn = pn;
        self.params = [@{@"pn":@(pn)} mutableCopy];
    }
    return self;
}

@end

@implementation HttpListQueryResponse

-(NSArray*)list
{
    return self.page ? self.page[@"list"] : nil;
}

-(NSDictionary*)page
{
    return self.all ? self.all[@"page"] : nil;
}

-(void)parserResponse
{
    if (self.page) {
        self.totalRow = [self.page[@"totalRow"] integerValue];
        self.pageNumber = [self.page[@"pageNumber"] integerValue];
        self.totalPage = [self.page[@"totalPage"] integerValue];
        self.pageSize = [self.page[@"pageSize"] integerValue];

        self.dtos = [[NSMutableArray alloc] init];
        for (NSDictionary* dict in self.list) {
            BaseListDTO* dto = [self makeDtoWith:dict];
            [self.dtos addObject:dto];
        }
    }
}

-(BaseListDTO*)makeDtoWith:(NSDictionary*)dict
{
    return nil;
}
@end
