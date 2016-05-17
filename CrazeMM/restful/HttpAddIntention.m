//
//  HttpAddIntention.m
//  CrazeMM
//
//  Created by saix on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpAddIntention.h"


@implementation HttpAddIntentionRequest

-(instancetype)initWithSid:(NSInteger)sid;
{
    self = [super init];
    if (self) {
        self.sid = sid;
        self.params = [@{@"sid" : @(sid)} mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/supply/addIntention");
}

-(NSString*)method
{
    return @"GET";
}

@end

@implementation HttpAddViewRequest

-(instancetype)initWithSid:(NSInteger)sid;
{
    self = [super init];
    if (self) {
        self.sid = sid;
        self.params = [@{@"sid" : @(sid)} mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    return COMB_URL(@"/rest/supply/addView");
}

-(NSString*)method
{
    return @"GET";
}

@end
