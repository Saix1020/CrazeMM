//
//  HttpAddIntention.h
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpAddIntentionRequest : BaseHttpRequest

@property (nonatomic) NSInteger sid;

-(instancetype)initWithSid:(NSInteger)sid;

@end

@interface HttpAddViewRequest : BaseHttpRequest

@property (nonatomic) NSInteger sid;

-(instancetype)initWithSid:(NSInteger)sid;

@end