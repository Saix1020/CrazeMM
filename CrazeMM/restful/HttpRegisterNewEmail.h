//
//  HttpRegisterNewEmail.h
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "BaseHttpRequest.h"

@interface HttpRegisterNewEmailRequest : BaseHttpRequest

-(instancetype)initWithNewEmail:(NSString*)newEmail andCaptchaEmailNew:(NSString*)captchaEmailNew andCaptchaEmailOrignal:(NSString*)captchaEmailOrignal;


@end

@interface HttpUpdateEmailRequest : BaseHttpRequest

-(instancetype)initWithNewEmail:(NSString*)newEmail andCaptchaEmailNew:(NSString*)captchaEmailNew andCaptchaEmailOrignal:(NSString*)captchaEmailOrignal;


@end
