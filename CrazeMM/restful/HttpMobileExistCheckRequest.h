//
//  HttpMobileExistCheckRequest.h
//  CrazeMM
//
//  Created by Mao Mao on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpMobileExistCheckRequest : BaseHttpRequest

-(instancetype)initWithMobile:(NSString*)mobile;

@end

@interface HttpMobileExistCheckResponse : BaseHttpResponse

@end