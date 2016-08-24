//
//  NSString+Utils.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

-(CGSize)boundingRectWithFont:(UIFont*)font andWidth:(CGFloat)width
{
    CGSize boundingSize = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize requiredSize = CGSizeZero;
    requiredSize = [self boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    return requiredSize;
}

-(CGSize)boundingWidthWithFont:(UIFont*)font
{
    return  [self sizeWithAttributes:@{NSFontAttributeName: font}];
}

-(UIImage*)image
{
    return [UIImage imageNamed:self];
}

+(NSString*)leftTimeString:(NSInteger)millisecond
{
    NSUInteger days = floor(millisecond/1000/3600/24);
    NSUInteger hours = floor(millisecond/1000/3600%24);
    NSUInteger mins = floor(((millisecond)% (1000 * 3600))/1000/60);
    
    return [NSString stringWithFormat:@"%lu 天 %lu 小时 %lu 分钟", days, hours, mins];
}

+(NSString*)leftTimeString2:(NSInteger)millisecond
{
    NSUInteger days = floor(millisecond/1000/3600/24);
    NSUInteger hours = floor(millisecond/1000/3600%24);
    NSUInteger mins = floor(((millisecond)% (1000 * 3600))/1000/60);
//    NSUInteger secs = floor(((millisecond)% (1000))/3600/1000/60);
    
//    NSMutableString* string = [[NSMutableString alloc] init];
//    if (days>0) {
//        [string appendString:[NSString stringWithFormat:@"%lu 天 ", days]];
//    }
//    if (days>0 && ) {
//        <#statements#>
//    }
//    [string appendString:[NSString stringWithFormat:@"%%lu小时%lu分钟%lu秒",hours, mins]];
//    return [NSString stringWithFormat:@"%lu天%lu小时%lu分钟%lu秒", days, hours, mins, secs];
    return [NSString stringWithFormat:@"%lu天%lu小时%lu分钟", days, hours, mins];
}

-(NSString *)countNumAndChangeformat
{
    int count = 0;
    long long int a = self.longLongValue;
    while (a != 0)    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:self];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

+(NSArray*)formatePrice:(CGFloat)price
{
    NSString* priceString = [NSString stringWithFormat:@"%.02f", price];
    
    NSArray* array = [priceString componentsSeparatedByString:@"."];
    
    NSString* firstString = [array[0] countNumAndChangeformat];
    NSString* secondString = [NSString stringWithFormat:@".%@", array[1]];
    
    return @[firstString, secondString];
}

-(NSDate*) convertToDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:self];
    return date;
}

@end
