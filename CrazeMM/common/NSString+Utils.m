//
//  NSString+Utils.m
//  CrazeMM
//
//  Created by saix on 16/5/1.
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

@end
