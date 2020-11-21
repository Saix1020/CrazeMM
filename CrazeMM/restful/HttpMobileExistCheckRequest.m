//
//  HttpMobileExistCheckRequest.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpMobileExistCheckRequest.h"

@implementation HttpMobileExistCheckRequest

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.params =  [@{} mutableCopy];;
        
    }
    
    return self;
}


-(instancetype)initWithMobile:(NSString*)mobile;
{
    self = [self init];
    
    if (self) {
        self.params =  [@{
                          @"mobile" : mobile,
                          } mutableCopy];;
        
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/user/isMobileNotExist?json");
}

-(Class)responseClass
{
    return [HttpMobileExistCheckResponse class];
}


@end

@implementation HttpMobileExistCheckResponse

-(BOOL)ok
{
    if (!self.all) {
        return NO;
    }
    NSNumber* result = self.all[@"r"];
    return [result intValue] == 1;
}

-(NSString*)errorMsg
{
    return @"该手机号已经注册";
}

@end
