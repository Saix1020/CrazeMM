//
//  HttpUserInfo.m
//  CrazeMM
//
//  Created by saix on 16/6/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpUserInfo.h"

@implementation HttpUserInfoRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/user/me");
}

-(NSString*)method
{
    return @"GET";
}

-(Class)responseClass
{
    return [HttpUserInfoResponse class];
}

@end

@implementation HttpUserInfoResponse

-(NSDictionary*)me
{
    return self.all?self.all[@"me"]:nil;
}

-(void)parserResponse
{
    if (self.me) {
        self.mineUserInfoDto = [[MineUserInfoDTO alloc] initWith:self.me];
    }
}

@end