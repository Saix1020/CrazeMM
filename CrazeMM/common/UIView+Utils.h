//
//  UIView+Utils.h
//  CrazeMM
//
//  Created by saix on 16/4/22.
//  Copyright © 2016年 189. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

-(void)backgroundColorFrom:(UIColor*)fromColor To:(UIColor*)toColor;

+(UIView*)lineViewWithColor:(UIColor*)color andWidth:(CGFloat)width;


-(UIImage*)imageForView;
- (UIResponder*)findFirstResponder;
@end
