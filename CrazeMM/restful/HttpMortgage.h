//
//  HttpMortgage.h
//  CrazeMM
//
//  Created by saix on 16/6/29.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpListQuery.h"
#import "MortgageDTO.h"

@interface HttpMortgageRequest : HttpListQueryRequest
@property (nonatomic) NSInteger status;

-(instancetype)initWithPageNum:(NSInteger)pn andStatus:(NSInteger)status;

@end

@interface HttpMortgageResponse : HttpListQueryResponse

@end