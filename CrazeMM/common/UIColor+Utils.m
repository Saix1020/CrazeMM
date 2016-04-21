//
//  UIColor+Utils.m
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)


+(id)UIColorFromRGB:(NSUInteger) rgbValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

+(id)UIColorFromRGB:(NSUInteger)rgbValue
         alphaValue:(CGFloat) alphaValue
{
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue];
}

@end
