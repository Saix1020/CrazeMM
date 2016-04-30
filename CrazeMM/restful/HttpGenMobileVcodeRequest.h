//
//  HttpGenMobileVcodeRequest.h
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpGenMobileVcodeRequest : BaseHttpRequest
-(instancetype)initWithPicCaptacha:(NSString*)picCaptachaser andMobile:(NSString*)mobile;
@end

@interface HttpGenMobileVcodeResponse : BaseHttpResponse

@end