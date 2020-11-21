//
//  HttpRandomCodeRequest.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/30.
//  Copyright © 2016年 189. All rights reserved.
//

#import "HttpRandomCodeRequest.h"

@implementation HttpRandomCodeRequest

-(Class)responseClass
{
    return [HttpRandomCodeResponse class];
}

-(BOOL)needToken
{
    return NO;
}

-(NSString*)url
{
    return COMB_URL(RANDOM_DATA_PATH);
}

-(NSString*)method
{
    return @"GET";
}

-(AFPromise*)request
{
    return [self requestWithAcceptContentTypes:[NSSet setWithObjects:@"image/jpeg", nil]];
}


@end

@implementation HttpRandomCodeResponse

-(NSData*)picData
{
    return (NSData*)self.all;
}

@end
