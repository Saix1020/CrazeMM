//
//  UIColor+Utils.h
//  CrazeMM
//
//  Created by saix on 16/4/18.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

+(UIColor*)UIColorFromRGB:(NSUInteger) rgbValue;

+(UIColor*)UIColorFromRGB:(NSUInteger)rgbValue
         alphaValue:(CGFloat) alphaValue;


@end
