//
//  HttpSignupRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpSignupRequest.h"

@interface HttpSignupRequest ()


@end

@implementation HttpSignupRequest


-(instancetype)initWithMobile:(NSString*)mobile andCaptchaPhone:(NSString*)captchaPhone andPassword:(NSString*)password andPictureCaptcha:(NSString*)pictureCaptcha
{
    self = [self init];
    if (self) {
        self.params =  [@{
                          @"phone" : mobile,
                          @"captchaPhone" : captchaPhone,
                          @"userType" : @(0),
                          @"password" : password,
                          @"passwordConfirm" : password,
                          @"pictureCaptcha" : pictureCaptcha,
                          } mutableCopy];
    }
    return self;
}
-(instancetype)initWithMobile:(NSString*)mobile andCaptchaPhone:(NSString*)captchaPhone andPassword:(NSString*)password
{
    self = [self init];
    if (self) {
        self.params =  [@{
                          @"phone" : mobile,
                          @"captchaPhone" : captchaPhone,
                          @"userType" : @(0),
                          @"password" : password,
                          @"passwordConfirm" : password,
                          } mutableCopy];
    }
    return self;
}

-(AFHTTPSessionManager*)manager
{
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];
    
    [mgr.requestSerializer setValue:@"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    return mgr;
    
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

-(Class)responseClass
{
    return [HttpSignupResponse class];
}

@end

@implementation HttpSignupResponse




@end

