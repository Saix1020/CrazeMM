//
//  HttpMobileExistCheckRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
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
    return COMB_URL(@"/rest/user/isMobileNotExist");
}


@end

@implementation HttpMobileExistCheckResponse



@end
