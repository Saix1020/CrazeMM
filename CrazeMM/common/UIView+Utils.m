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

+(UIView*)lineViewWithColor:(UIColor*)color andWidth:(CGFloat)width
{
    UIView* line = [[UIView alloc] init];
    line.layer.borderColor = color.CGColor;
    line.layer.borderWidth = width;
    line.height = 1;
    return line;
}


-(UIImage*)imageForView
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size,NO,[[UIScreen mainScreen] scale]);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIResponder*)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}

@end
