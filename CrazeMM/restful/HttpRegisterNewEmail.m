//
//  HttpRegisterNewEmail.m
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpRegisterNewEmail.h"

@implementation HttpRegisterNewEmailRequest

-(instancetype)initWithNewEmail:(NSString*)newEmail andCaptchaEmailNew:(NSString*)captchaEmailNew andCaptchaEmailOrignal:(NSString*)captchaEmailOrignal;
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"newEmail" : newEmail,
                         @"captchaEmailNew" : captchaEmailNew
                         
                         } mutableCopy];
    }
    
    return self;
}


-(NSString*)url
{
    return COMB_URL(@"/rest/user/registerNewEmail");
}

-(NSString*)method
{
    return @"POST";
}



@end
