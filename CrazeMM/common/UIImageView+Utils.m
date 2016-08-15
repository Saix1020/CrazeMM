//
//  UIImageView+Utils.m
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import "UIImageView+Utils.h"

@implementation UIImageView (Utils)

-(void)roundImageWithBordWidth:(CGFloat)width andBordColor:(UIColor*)color
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
