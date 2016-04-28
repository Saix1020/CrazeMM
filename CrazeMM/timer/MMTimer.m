//
//  MMTimer.m
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MMTimer.h"

@implementation MMTimer


static MMTimer *sharedInstance = nil;

+ (MMTimer *)sharedInstance
{
    @synchronized(self){
        if (sharedInstance == nil) {
            sharedInstance = [[MMTimer alloc] init];
            
            
        }
    }
    return sharedInstance;
}


-(RACSignal*)oneSecondSignal
{
    if (!_oneSecondSignal) {
        _oneSecondSignal = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]];
    }
    
    return _oneSecondSignal;
}


+(RACSignal*)createTimer:(NSTimeInterval*)interval andStopFlag:(BOOL)flag
{
    
    return  [[RACSignal interval:4 onScheduler:[RACScheduler mainThreadScheduler]
                               ]
                              takeUntilBlock:^BOOL (id x){
                                  return flag;
                              }];
}


@end
