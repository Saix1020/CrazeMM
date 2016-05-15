//
//  HttpOrderCancel.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/14.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpOrderCancelRequest : BaseHttpRequest

@property (nonatomic) NSInteger orderId;

-(instancetype)initWithOrderId:(NSInteger)orderId;

@end


@interface HttpOrderCancelResponse : BaseHttpResponse

// No response?
@end