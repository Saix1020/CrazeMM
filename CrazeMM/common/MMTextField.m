//
//  MMTextField.m
//  CrazeMM
//
//  Created by Mao Mao on 16/5/1.
//  Copyright © 2016年 189. All rights reserved.
//

#import "MMTextField.h"

@implementation MMTextField

-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x += 6.f;
    rect.size.width -= 6.f;
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}


@end
