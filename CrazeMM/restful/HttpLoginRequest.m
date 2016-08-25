//
//  HttpLoginRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpLoginRequest.h"

@implementation HttpLoginRequest

-(AFHTTPSessionManager*)manager
{
    AFHTTPSessionManager* mgr = [super manager];
    
    mgr.requestSerializer.timeoutInterval = 10.0f; // set timeout 10s
    
    return mgr;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.user = @"";
        self.password = @"";
        self.remember = NO;
        
        self.params =  [@{
                     @"account" : self.user, //用户账号，可以是用户名/手机号/邮箱，必须
                     @"pwd" : self.password, //密码，必须
                     @"remember" : @(self.remember) //是否记录用户名
                     } mutableCopy];;

    }
    
    return self;
}

-(instancetype)initWithUser:(NSString*)user andPassword:(NSString*)password andRemember:(BOOL)remember
{
    self = [self init];
    
    if (self) {
        self.user = user;
        self.password = password;
        self.remember = remember;
        
        self.params =  [@{
                          @"account" : self.user, //用户账号，可以是用户名/手机号/邮箱，必须
                          @"pwd" : self.password, //密码，必须
                          @"remember" : @(self.remember) //是否记录用户名
                          } mutableCopy];;
    }
    

    return self;
}

-(Class)responseClass
{
    return [HttpLoginResponse class];
}

-(NSString*)tokenName
{
    return @"login_token";
}

-(NSString*)url
{
    return COMB_URL(LOGIN_PATH);
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
    // set login time out
    [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.manager.requestSerializer.timeoutInterval = 30.f;
    [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    return [super request].then(^(id responseObj){
        
        return responseObj;
    });
}

-(NSDictionary*)getTokenParams
{
    return @{
             @"name":self.tokenName
             };
}

-(void)dealloc
{
    NSLog(@"dealloc");
}


@end

@implementation HttpLoginResponse

-(NSString*)errorTitle
{
    return @"Login Failed";
}

-(NSString*)errorDetail
{
    if (self.data[@"lessTimes"]) {
        NSNumber* leftTime = self.data[@"lessTimes"];
        return [NSString stringWithFormat:@"剩余尝试机会: %d", [leftTime intValue]]; ;
    }
    else {
        return nil;
    }
}

-(NSString*)errorMsg
{
    return [NSString stringWithFormat:@"%@: %@", [super errorMsg], [self errorDetail]];
}


@end
