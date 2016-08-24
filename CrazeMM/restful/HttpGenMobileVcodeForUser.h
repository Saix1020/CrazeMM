//
//  HttpGenMobileVcodeForUser.h
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpGenMobileVcodeForUserRequest : BaseHttpRequest


@end

@interface HttpGenMobileVcodeForUserResponse : BaseHttpResponse

@property (nonatomic, readonly) NSInteger lessTimes;
@property (nonatomic, readonly) NSInteger seq;
@end