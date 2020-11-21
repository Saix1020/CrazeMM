//
//  HttpRegisterNewMobile.m
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpRegisterNewMobile.h"

@implementation HttpRegisterNewMobileRequest

-(instancetype)initWithNewMobile:(NSString*)newMobile andCaptchaMobileNew:(NSString*)captchaMobileNew andCaptchaMobileOrignal:(NSString*)captchaMobileOrignal
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"newMobile" : newMobile,
                         @"captchaMobileNew" : captchaMobileNew
                        
                         } mutableCopy];
    }
    
    return self;
}


-(NSString*)url
{
    return COMB_URL(@"/rest/user/registerNewMobile");
}

-(NSString*)method
{
    return @"POST";
}

@end

@implementation HttpUpdateMobileRequest

-(instancetype)initWithNewMobile:(NSString*)newMobile andCaptchaMobileNew:(NSString*)captchaMobileNew andCaptchaMobileOrignal:(NSString*)captchaMobileOrignal
{
    self = [super init];
    if (self) {
        self.params = [@{
                         @"captchaMobile" : captchaMobileOrignal,
                         @"newMobile" : newMobile,
                         @"captchaMobileNew" : captchaMobileNew
                         
                         } mutableCopy];
    }
    
    return self;
}


-(NSString*)url
{
    return COMB_URL(@"/rest/user/updateMobile");
}

-(NSString*)method
{
    return @"POST";
}


-(BOOL)needToken
{
    return YES;
}

-(NSString*)tokenName
{
    return @"modify_mobile_token";
}

@end

