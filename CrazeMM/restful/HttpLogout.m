//
//  HttpLogout.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/6.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpLogout.h"

@implementation HttpLogoutRequest

-(NSString*)url
{
    return COMB_URL(@"/rest/user/logout");
}

-(NSString*)method
{
    return @"GET";
}

@end
