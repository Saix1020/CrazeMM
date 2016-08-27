//
//  HttpGenMobileVcodeForUser.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpGenMobileVcodeForUser.h"

@implementation HttpGenMobileVcodeForUserRequest

-(AFHTTPSessionManager*)manager
{
    AFHTTPSessionManager* mgr = [super manager];
    
    [mgr.requestSerializer setValue:@"Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.76 Mobile Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    return mgr;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/genMobileVcodeForUser");
}

-(Class)responseClass
{
    return [HttpGenMobileVcodeForUserResponse class];
}


@end

//{"returnCode":0,"data":{"lessTimes":3,"seq":2}}
@implementation HttpGenMobileVcodeForUserResponse

-(BOOL)ok
{
    if (!self.all || self.all.allKeys.count == 0) {
        return NO;
    }
    return [self.all[@"returnCode"] integerValue] == 0;
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
    return [NSString stringWithFormat:@"手机验证码已经成功发送，请注意查收，您还有%ld次获取机会", self.lessTimes];
}

@end