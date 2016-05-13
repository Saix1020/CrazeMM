//
//  HttpCheckMessageCodeRequest.h
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpCheckMessageCodeRequest : BaseHttpRequest

-(instancetype)initWithMobileCode:(NSString*)code andMobile:(NSString*)mobile;

@end

@interface HttpCheckMessageCodeResponse : BaseHttpResponse

@end;
