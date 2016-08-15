//
//  HttpRandomCodeRequest.h
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpRandomCodeRequest : BaseHttpRequest


@end

@interface HttpRandomCodeResponse : BaseHttpResponse

@property (nonatomic, readonly) NSData* picData;

@end