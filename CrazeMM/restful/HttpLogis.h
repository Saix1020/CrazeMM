//
//  HttpLogis.h
//  CrazeMM
//
//  Created by Mao Mao on 16/5/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"
#import "LogisDTO.h"

@interface HttpLogisRequest : BaseHttpRequest

@end

@interface HttpLogisResponse : BaseHttpResponse

@property (nonatomic, strong) NSMutableArray* logises;

@end
