//
//  HttpGenEmailVcodeForUser.h
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpGenEmailVcodeForUserRequest : BaseHttpRequest

@end

@interface HttpGenEmailVcodeForUserResponse : BaseHttpResponse

@property (nonatomic, readonly) NSInteger lessTimes;
@property (nonatomic, readonly) NSInteger seq;
@end