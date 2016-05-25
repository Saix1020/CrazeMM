//
//  MMTimer.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTimer : NSObject


@property (nonatomic, strong) RACSignal* oneSecondSignal;
@property (nonatomic, strong) RACSignal* oneMinuteSignal;


+ (MMTimer *)sharedInstance;


+(RACSignal*)createTimer:(NSTimeInterval*)interval andStopFlag:(BOOL)flag;

@end
