//
//  HttpCheckMessageCodeRequest.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpCheckMessageCodeRequest.h"

@implementation HttpCheckMessageCodeRequest



-(instancetype)initWithMobileCode:(NSString*)code andMobile:(NSString*)mobile
{
    self = [self init];
    
    if (self) {
        self.params =  [@{
                          @"messageCode" : code,
                          @"mobile" : mobile,
                          } mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/checkMessageCode?json");
}

-(Class)responseClass
{
    return [HttpCheckMessageCodeResponse class];
}

@end


@implementation HttpCheckMessageCodeResponse

-(BOOL)ok
{
    if (!self.all) {
        return NO;
    }
    else {
        NSNumber* ok = self.all[@"r"];
        return [ok intValue] == 1;
    }
}

-(NSString*)errorMsg
{
    return @"手机验证码错误";
}

@end