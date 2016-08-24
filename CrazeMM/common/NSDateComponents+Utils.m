//
//  NSDateComponents+Utils.m
//  CrazeMM
//
//  Created by Mao Mao on 16/4/28.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NSDateComponents+Utils.h"

@implementation NSDateComponents (Utils)

+(NSDateComponents*)convertTimeInterval:(NSTimeInterval)interval
{
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date1];
    
    // Get conversion to months, days, hours, minutes
    NSCalendarUnit unitFlags = kCFCalendarUnitMinute | kCFCalendarUnitHour | kCFCalendarUnitDay;
    
    return [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    //NSLog(@"Break down: %i min : %i hours : %i days : %i months", [breakdownInfo minute], [breakdownInfo hour], [breakdownInfo day], [breakdownInfo month]);
}

+(NSString*)timeLabelString:(NSTimeInterval)interval
{
    
    NSDateComponents* components = [NSDateComponents convertTimeInterval:interval];
    
    return [NSString stringWithFormat:@"%02lu 天 %02lu 小时 %02lu 分钟", (unsigned long)[components day], (unsigned long)[components hour], (unsigned long)[components minute]];
}

@end
