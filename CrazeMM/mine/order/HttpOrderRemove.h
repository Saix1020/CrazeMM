//
//  HttpOrderRemove.h
//  CrazeMM
//
//  Created by saix on 16/5/13.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpOrderRemoveRequest : BaseHttpRequest

-(instancetype)initWithOrderIds:(NSArray*)ids;

@end
