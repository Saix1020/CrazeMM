//
//  NSNull+Utils.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/8.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NSNull+Utils.h"

@implementation NSNull (Utils)

-(NSInteger)integerValue
{
    return -1;
}

-(CGFloat)floatValue
{
    return -1.f;
}

-(BOOL)boolValue
{
    return NO;
}

-(NSString*)description
{
    return @"";
}

-(NSInteger)length
{
    return 0;
}

-(NSInteger)count
{
    return 0;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    return;
}
- (nullable id)valueForKey:(NSString *)key
{
    return nil;
}

@end
