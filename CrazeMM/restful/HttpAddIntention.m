//
//  HttpAddIntention.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/11.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpAddIntention.h"


@implementation HttpAddIntentionRequest

-(instancetype)initWithSid:(NSInteger)sid andType:(MMType)type
{
    self = [super init];
    if (self) {
        self.sid = sid;
        self.type = type;
        self.params = type==kTypeBuy? [@{@"bid" : @(sid)} mutableCopy] : [@{@"sid" : @(sid)} mutableCopy];
    }
    return self;
}

-(NSString*)url
{
    return self.type ==kTypeBuy? COMB_URL(@"/rest/buy/addIntention"): COMB_URL(@"/rest/supply/addIntention");
}

-(NSString*)method
{
    return @"GET";
}

+(void)addIntention:(NSInteger)sid andType:(MMType)type
{
    HttpAddIntentionRequest* request = [[HttpAddIntentionRequest alloc] initWithSid:sid andType:type];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
    })
    .catch(^(NSError* error){
    });

}

@end

@implementation HttpAddViewRequest

-(instancetype)initWithSid:(NSInteger)sid andType:(MMType)type
{
    self = [super init];
    if (self) {
        self.sid = sid;
        self.type = type;
        self.params = type==kTypeBuy? [@{@"bid" : @(sid)} mutableCopy] : [@{@"sid" : @(sid)} mutableCopy];

    }
    return self;
}

-(NSString*)url
{
    return self.type ==kTypeBuy? COMB_URL(@"/rest/buy/addView"):COMB_URL(@"/rest/supply/addView");
}

-(NSString*)method
{
    return @"GET";
}

+(void)addView:(NSInteger)sid andType:(MMType)type
{
    HttpAddViewRequest* request = [[HttpAddViewRequest alloc] initWithSid:sid andType:type];
    [request request]
    .then(^(id responseObj){
        NSLog(@"%@", responseObj);
    })
    .catch(^(NSError* error){
    });
    
}

@end
