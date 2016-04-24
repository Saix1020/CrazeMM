//
//  UserCenter.m
//  CrazeMM
//
//  Created by saix on 16/4/24.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UserCenter.h"

@interface UserCenter()

@property (nonatomic) BOOL isLogined;


@end

@implementation UserCenter

static UserCenter *defaultUserCenter = nil;

+ (UserCenter *)defaultCenter
{
    @synchronized(self){
        if (defaultUserCenter == nil) {
            defaultUserCenter = [[UserCenter alloc] init];
        }
    }
    return defaultUserCenter;
}

-(void)setLogined
{
    [UserCenter defaultCenter].isLogined = true;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessBroadCast
                                                        object:self];
}

@end
