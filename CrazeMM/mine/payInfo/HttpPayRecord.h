//
//  HttpPayRecord.h
//  CrazeMM
//
//  Created by Mao Mao on 16/8/21.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpListQuery.h"


#pragma mark - HttpPayRecord

@interface HttpPayRecordRequest : HttpListQueryRequest

@property (nonatomic) NSInteger status;

-(instancetype)initWithPageNum:(NSInteger)pn andStatus:(NSInteger) status;

@end

@interface HttpPayRecordResponse : HttpListQueryResponse

@end

#pragma mark - HttpPayReflesh

@interface HttpPayRefreshRequest : BaseHttpRequest

@property (nonatomic) NSInteger payNo;

-(instancetype)initWithPayNo:(NSInteger)payNo;

@end

#pragma mark - HttpPayCancel

@interface HttpPayCancelRequest : BaseHttpRequest

@property (nonatomic) NSInteger payNo;

-(instancetype)initWithPayNo:(NSInteger)payNo;

@end

#pragma mark - HttpPayData

@interface HttpPayDataRequest : BaseHttpRequest

@property (nonatomic) NSInteger payNo;

-(instancetype)initWithPayNo:(NSInteger)payNo;

@end



