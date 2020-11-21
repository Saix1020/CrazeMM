//
//  HttpGenMobileVcodeRequest.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpGenMobileVcodeRequest.h"

@implementation HttpGenMobileVcodeRequest

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.params =  [@{} mutableCopy];;
        
    }
    
    return self;
}


-(instancetype)initWithPicCaptacha:(NSString*)picCaptachaser andMobile:(NSString*)mobile
{
    self = [self init];
    
    if (self) {
        
        self.params =  [@{
                          @"pictureCaptcha" : picCaptachaser,
                          @"mobile" : mobile
                          } mutableCopy];
        
    }
    
    
    return self;
}

-(instancetype)initWithMobile:(NSString*)mobile
{
    self = [self init];
    
    if (self) {
        
        self.params =  [@{
                          @"mobile" : mobile
                          } mutableCopy];;
        
    }
    
    return self;
}


-(AFHTTPSessionManager*)manager
{
    AFHTTPSessionManager* mgr = [super manager];
    
    [mgr.requestSerializer setValue:@"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    return mgr;
}

-(NSString*)url
{
    return COMB_URL(GEN_MOBILE_VCODE_PATH);
}

-(NSString*)method
{
    return @"POST";
}

-(Class)responseClass
{
    return [HttpGenMobileVcodeResponse class];
}

@end

@implementation HttpGenMobileVcodeResponse

-(BOOL)ok
{
    if (!self.all) {
        return NO;
    }
    else {
        NSNumber* returnCode = self.all[@"returnCode"];
        if (!returnCode) {
            return NO;
        }
        else {
            return [returnCode integerValue] == 0;
        }
    }
}

-(NSString*)errorTitle
{
    return @"获取手机短信验证码失败";
}

-(NSString*)errorMsg
{
    if (!self.all) {
        return @"";
    }
    else {
        return self.all[@"errMsg"];
    }
}

-(NSDictionary*)data
{
    if (!self.all) {
        return @{};
    }
    else {
        return self.all[@"data"];
    }
}

-(NSInteger)lessTimes
{
    return [self.data[@"lessTimes"] integerValue];
}

-(NSInteger)seq
{
    return [self.data[@"seq"] integerValue];
}


-(NSString*)description
{
    return [NSString stringWithFormat:@"手机验证码已经成功发送，请注意查收，您还有%ld次获取机会", self.lessTimes];
}


-(NSString*)errorDetail
{
    if (!self.all) {
        return @"";
    }
    else {
        if ([self.all[@"returnCode"] intValue] == -2) {
            return @"次数达到限定次数";
        }
        else {
            NSNumber* lessTimes = self.data[@"lessTimes"];
            if (!lessTimes) {
                return @"";
            }
            else {
                return [NSString stringWithFormat:@"剩余次数: %d", [lessTimes intValue]] ;

            }

        }
    }
}



@end
