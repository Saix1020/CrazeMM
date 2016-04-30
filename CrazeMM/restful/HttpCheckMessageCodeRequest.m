//
//  HttpCheckMessageCodeRequest.m
//  CrazeMM
//
//  Created by saix on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpCheckMessageCodeRequest.h"

@implementation HttpCheckMessageCodeRequest



-(instancetype)initWithMobileCode:(NSString*)code andMobile:(NSString*)mobile
{
    self = [self init];
    
    if (self) {
        self.params =  [@{
                          @"messageCode" : code,
                          @"mobile" : mobile,
                          } mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/checkMessageCode");
}

@end
