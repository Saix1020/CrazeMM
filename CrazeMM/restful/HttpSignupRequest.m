//
//  HttpSignupRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSignupRequest.h"

@implementation HttpSignupRequest


-(instancetype)initWithMobile:(NSString*)mobile andCaptchaPhone:(NSString*)captchaPhone andPassword:(NSString*)password andPictureCaptcha:(NSString*)pictureCaptcha
{
    self = [self init];
    if (self) {
        self.params =  [@{
                          @"mobile" : mobile,
                          @"captchaPhone" : captchaPhone,
                          @"userType" : @(0),
                          @"password" : password,
                          @"passwordConfirm" : password,
                          @"pictureCaptcha" : pictureCaptcha,
                          } mutableCopy];
    }
    return self;
}

-(BOOL)needToken
{
    return YES;
}

-(NSString*)tokenName
{
    return @"signup_token";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/user");
}

-(NSString*)method
{
    return @"POST";
}

@end
