//
//  HttpSignupRequest.h
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpSignupRequest : BaseHttpRequest

-(instancetype)initWithMobile:(NSString*)mobile andCaptchaPhone:(NSString*)captchaPhone andPassword:(NSString*)password andPictureCaptcha:(NSString*)pictureCaptcha;

@end
