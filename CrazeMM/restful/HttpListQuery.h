//
//  HttpListQuery.h
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpListQueryRequest : BaseHttpRequest

@property (nonatomic) NSInteger pn;

-(instancetype)initWith:(NSInteger)pn;
-(instancetype)initWithPageNum:(NSInteger)pn;
-(NSString*)urlWithPn:(NSString*)url;

@end

@interface HttpListQueryResponse : BaseHttpResponse

@property (nonatomic) NSInteger totalRow;
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger totalPage;
@property (nonatomic) NSInteger pageSize;
@property (nonatomic, readonly) NSDictionary* page;
@property (nonatomic, readonly) NSArray* list;
@property (nonatomic, strong) NSMutableArray* dtos;
-(id)makeDtoWith:(NSDictionary*)dict;

@end
