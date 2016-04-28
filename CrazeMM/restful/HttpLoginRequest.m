//
//  HttpLoginRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpLoginRequest.h"

@implementation HttpLoginRequest

-(NSString*)url
{
//    if (self.url) {
        return COMB_URL(LOGIN_PATH);
//    }
//    else {
//        
//    }
}

-(NSDictionary*)params
{
    return @{
             //"login_token" -8863622791707940752 //表单TOKEN，防止二次提交, 必须
             @"account" : @"xuanxuan", //用户账号，可以是用户名/手机号/邮箱，必须
             @"pwd" : @"123456", //密码，必须
             @"remember" : @"true" //是否记录用户名
             };
}

-(NSString*)method
{
    return @"POST";
}

-(BOOL)needToken
{
    return YES;
}

-(AFPromise*)login
{
    return [super request];
}


-(void)dealloc
{
    NSLog(@"dealloc");
}


@end
