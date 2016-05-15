//
//  HttpOrderDelete.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpOrderDeleteRequest : BaseHttpRequest

@property (nonatomic) NSString* ids;

-(instancetype)initWithOrderIds:(NSString*)orderIds;

@end

@interface HttpOrderDeleteResponse : BaseHttpResponse

@end