//
//  HttpGenMobileVcodeRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
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
                          } mutableCopy];;
        
    }
    
    
    return self;
}


-(NSString*)url
{
    return COMB_URL(GEN_MOBILE_VCODE_PATH);
}

-(NSString*)method
{
    return @"POST";
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

//@property (nonatomic, readonly) NSString* errorTitle;
//@property (nonatomic, readonly) NSString* errorMsg;
//@property (nonatomic, readonly) NSDictionary* data;
//@property (nonatomic, readonly) NSString* errorDetail;

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
