//
//  HttpGenMobileVcodeRequest.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpGenMobileVcodeRequest : BaseHttpRequest
-(instancetype)initWithPicCaptacha:(NSString*)picCaptachaser andMobile:(NSString*)mobile;
-(instancetype)initWithMobile:(NSString*)mobile;

@end

@interface HttpGenMobileVcodeResponse : BaseHttpResponse
@property (nonatomic, readonly) NSInteger lessTimes;
@property (nonatomic, readonly) NSInteger seq;

@end