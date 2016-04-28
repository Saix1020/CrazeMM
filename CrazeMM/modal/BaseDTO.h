//
//  BaseDTO.h
//  CrazeMM
//
//  Created by saix on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDTO : NSObject

//@property (nonatomic, strong) RACSignal* rac_signal;


-(void)decode:(NSDictionary *)dic;
-(NSDictionary *)encode;

@end
