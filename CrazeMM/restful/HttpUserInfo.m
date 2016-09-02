//
//  HttpUserInfo.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/24.
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

@implementation HttpUserUpdateValidatedRequest

-(BOOL)needToken
{
    return YES;
}

-(NSString*)tokenName
{
    return @"validate_user_token";
}

-(instancetype)initWithUserInfo:(MineUserInfoDTO *)userInfo
{
    self = [super init];
    if (self) {
        if (userInfo.type == 0) { // 个人
            self.params = [@{
                             @"user.username" : userInfo.username,
                             @"userPerInfo.name" : userInfo.realName,
                             @"userPerInfo.identity" : userInfo.identity,
                             @"userPerInfo.weixin" : userInfo.weixin,
                             @"userPerInfo.qq" : userInfo.qq,
                             @"userPerInfo.sex" : userInfo.sex
                             } mutableCopy];
        }
        else {
            self.params = [@{
                             @"user.username" : userInfo.username,
                             @"userEntInfo.name" : userInfo.companyName,
                             @"userEntInfo.head" : userInfo.head,
                             @"userEntInfo.sex" : userInfo.sex,
                             @"userEntInfo.identity" : userInfo.identity,
                             @"userEntInfo.addrPid" : @(userInfo.addrPid),
                             @"userEntInfo.addrCid" : @(userInfo.addrCid),
                             @"userEntInfo.addrDid" : @(userInfo.addrDid),
                             @"userEntInfo.addrStreet" : userInfo.addrStreet,
                             } mutableCopy];
            
        }
    }
    
    return self;
}

-(NSString*)method
{
    return @"POST";
}

-(NSString*)url
{
    return COMB_URL(@"/rest/user/updateValidated");
}

@end