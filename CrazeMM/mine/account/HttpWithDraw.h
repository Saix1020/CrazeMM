//
//  HttpWithDraw.h
//  CrazeMM
//
//  Created by saix on 16/6/10.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "HttpListQuery.h"
#import "WithDrawLogDTO.h"

@interface HttpWithDrawRequest : BaseHttpRequest

-(instancetype)initWithBid:(NSInteger)bid andPassword:(NSString*)password andAmount:(CGFloat)amount;


@end

@interface HttpWithDrawLogRequest : HttpListQueryRequest


@end

@interface HttpWithDrawLogResponse : HttpListQueryResponse


@end