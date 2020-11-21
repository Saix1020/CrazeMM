//
//  HttpGenEmailVcode.m
//  CrazeMM
//
//  Created by saix on 16/8/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpGenEmailVcode.h"

@implementation HttpGenEmailVcodeRequest

-(AFHTTPSessionManager*)manager
{
    AFHTTPSessionManager* mgr = [super manager];
    
    [mgr.requestSerializer setValue:@"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    return mgr;
}


-(instancetype)initWithEmail:(NSString*)email;
{
    self = [self init];
    
    if (self) {
        self.params =  [@{
                          @"email" : email,
                          } mutableCopy];;
        
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/genEmailVcode");
}

-(Class)responseClass
{
    return [HttpGenEmailVcodeResponse class];
}


@end


@implementation HttpGenEmailVcodeResponse


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
    return self.all?self.all[@"data"]:@{};
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
    return [NSString stringWithFormat:@"邮箱验证码已经成功发送，请注意查收，您还有%ld次获取机会", self.lessTimes];
}

@end


@implementation HttpEmailExistCheckRequest

-(instancetype)initWithEmail:(NSString*)email;
{
    self = [self init];
    
    if (self) {
        self.params =  [@{
                          @"email" : email,
                          } mutableCopy];;
        
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/user/isEmailNotExist?json");
}

-(Class)responseClass
{
    return [HttpEmailExistCheckResponse class];
}

@end

@implementation HttpEmailExistCheckResponse

-(BOOL)ok
{
    return self.all[@"r"];
}

-(NSString*)errorMsg
{
    return @"该邮箱已经注册";
}


@end

