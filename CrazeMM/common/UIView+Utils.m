//
//  UIView+Utils.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

-(void)backgroundColorFrom:(UIColor*)fromColor To:(UIColor*)toColor
{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
}

@end
