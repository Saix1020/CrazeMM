//
//  FilterGoodInfo.m
//  CrazeMM
//
//  Created by Mao Mao on 16/6/25.
//  Copyright © 2016年 189. All rights reserved.
//

#import "FilterGoodInfo.h"

@implementation FilterGoodInfo

static FilterGoodInfo *sharedInstance = nil;

+ (FilterGoodInfo *)sharedInstance
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [[FilterGoodInfo alloc] init];
        }
    }
    return sharedInstance;
}



@end
