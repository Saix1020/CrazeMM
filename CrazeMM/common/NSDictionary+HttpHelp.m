//
//  NSDictionary+HttpHelp.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NSDictionary+HttpHelp.h"

@implementation NSDictionary (HttpHelp)


-(BOOL)ok
{
    NSString* ok = self[@"ok"];
    if (ok) {
        return [ok boolValue];
    }
    else {
        return NO;
    }
}

-(NSString*)msg
{
    NSString* msg = self[@"msg"];
    return msg;
}


-(NSDictionary*)data
{
    return self[@"data"];
}


@end
